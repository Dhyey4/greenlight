
from django.db import models
from django.contrib.auth.models import (
    AbstractBaseUser, BaseUserManager, PermissionsMixin
)
from django.utils import timezone
from django.dispatch import receiver 
from django.db.models.signals import post_save
from djstripe.models import *

class ArInternalMetadata(models.Model):
    key = models.CharField(primary_key=True, max_length=1000)
    value = models.CharField(max_length=1000, blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ar_internal_metadata'


class Features(models.Model):
    id = models.BigAutoField(primary_key=True)
    setting_id = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=1000)
    value = models.CharField(max_length=1000, blank=True, null=True)
    enabled = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'features'


class Invitations(models.Model):
    id = models.BigAutoField(primary_key=True)
    email = models.CharField(max_length=1000)
    provider = models.CharField(max_length=1000)
    invite_token = models.CharField(max_length=1000, blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'invitations'


class RolePermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=1000, blank=True, null=True)
    value = models.CharField(max_length=1000, blank=True, null=True)
    enabled = models.BooleanField(blank=True, null=True)
    role_id = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'role_permissions'


class Roles(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=1000, blank=True, null=True)
    priority = models.IntegerField(blank=True, null=True)
    can_create_rooms = models.BooleanField(blank=True, null=True)
    send_promoted_email = models.BooleanField(blank=True, null=True)
    send_demoted_email = models.BooleanField(blank=True, null=True)
    can_edit_site_settings = models.BooleanField(blank=True, null=True)
    can_edit_roles = models.BooleanField(blank=True, null=True)
    can_manage_users = models.BooleanField(blank=True, null=True)
    colour = models.CharField(max_length=1000, blank=True, null=True)
    provider = models.CharField(max_length=1000, blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()
    user_limit = models.IntegerField(blank=True, null=True)
    time_limit = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'roles'
        unique_together = (('name', 'provider'), ('priority', 'provider'),)


class Rooms(models.Model):
    id = models.BigAutoField(primary_key=True)
    user_id = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=1000, blank=True, null=True)
    uid = models.CharField(max_length=1000, blank=True, null=True)
    bbb_id = models.CharField(max_length=1000, blank=True, null=True)
    sessions = models.IntegerField(blank=True, null=True)
    last_session = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)
    room_settings = models.CharField(max_length=1000, blank=True, null=True)
    moderator_pw = models.CharField(max_length=1000, blank=True, null=True)
    attendee_pw = models.CharField(max_length=1000, blank=True, null=True)
    access_code = models.CharField(max_length=1000, blank=True, null=True)
    deleted = models.BooleanField()

    class Meta:
        managed = False
        db_table = 'rooms'


class SchemaMigrations(models.Model):
    version = models.CharField(primary_key=True, max_length=1000)

    class Meta:
        managed = False
        db_table = 'schema_migrations'


class Settings(models.Model):
    id = models.BigAutoField(primary_key=True)
    provider = models.CharField(max_length=1000)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'settings'


class SharedAccesses(models.Model):
    id = models.BigAutoField(primary_key=True)
    room_id = models.IntegerField(blank=True, null=True)
    user_id = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'shared_accesses'

class UserManager(BaseUserManager):

    def _create_user(self, email, password_digest, is_staff, is_superuser, **extra_fields):
        if not email:
            raise ValueError('Users must have an email address')
        now = timezone.now()
        email = self.normalize_email(email)
        user = self.model(
            email=email,
            is_superuser=is_superuser,
            is_staff=is_staff,
            # password=password_digest,
            last_login=now,
            created_at=now,
            # deleted=False,
            **extra_fields
        )
        user.save(using=self._db)
        return user

    def create_user(self, email=None, password_digest=None, **extra_fields):
        return self._create_user(email, password_digest, False, False, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        user = self._create_user(email, password, True, True, **extra_fields)
        user.set_password(password) 
        user.save(using=self._db)
        return user

    def create_employ(self, password_digest, email, **extra_fields):
        user = self._create_user(email, password_digest, False, False, **extra_fields)
        user.save(using=self._db)
        return user



class Users(AbstractBaseUser, PermissionsMixin):
    id = models.BigAutoField(primary_key=True)
    room_id = models.IntegerField(blank=True, null=True)
    provider = models.CharField(max_length=1000, blank=True, null=True)
    uid = models.CharField(max_length=1000, blank=True, null=True)
    name = models.CharField(max_length=1000, blank=True, null=True)
    username = models.CharField(max_length=1000, blank=True, null=True)
    email = models.CharField(max_length=1000, blank=True, null=True,unique=True)
    social_uid = models.CharField(max_length=1000, blank=True, null=True)
    image = models.CharField(max_length=1000, blank=True, null=True)
    password = models.CharField(max_length=100, db_column='password_digest')
    # password_digest = models.CharField(unique=True, max_length=1000, blank=True, null=True)
    accepted_terms = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)
    # email_verified = models.BooleanField(blank=True, null=True)
    language = models.CharField(max_length=1000, blank=True, null=True)
    reset_digest = models.CharField(max_length=1000, blank=True, null=True)
    reset_sent_at = models.DateTimeField(blank=True, null=True)
    activation_digest = models.CharField(max_length=1000, blank=True, null=True)
    # activated_at = models.DateTimeField(blank=True, null=True)
    deleted = models.BooleanField()
    role_id = models.BigIntegerField(blank=True, null=True)
    last_login = models.DateTimeField(blank=True,null=True,db_column="activated_at")
    is_superuser = models.BooleanField(db_column="email_verified",null=True,blank=True)
    is_staff = models.BooleanField(null=True,default=False)
    forgot_password = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    # objects of this type.
    objects = UserManager()

    class Meta:
        managed = True
        db_table = 'users'


class UsersRoles(models.Model):
    user_id = models.IntegerField(blank=True, null=True)
    role_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users_roles'


class Cart(models.Model):
    user_id = models.IntegerField(blank=True, null=True)
    product_id = models.CharField(max_length=200,blank=True,null=True)
    plan_id = models.CharField(max_length=200,null=True,blank=True)
    created_at = models.DateTimeField(auto_now_add=True,null=True,blank=True)

class ProductDescription(models.Model):
    product = models.CharField(max_length=200,blank=True,null=True)
    description  = models.TextField(null=True,blank=True)

class DemoRequest(models.Model):
    name = models.CharField(max_length=200,blank=True,null=True)
    email = models.CharField(max_length=200,blank=True,null=True)
    phone_number = models.CharField(max_length=200,blank=True,null=True)
    country = models.CharField(max_length=200,blank=True,null=True)
    commpany_name = models.CharField(max_length=200,blank=True,null=True)
    employee = models.CharField(max_length=200,blank=True,null=True)
    prefered_date = models.DateField(blank=True,null=True)
    prefered_time = models.TimeField(blank=True,null=True)
    information = models.TextField(blank=True,null=True)

class Subscribe(models.Model):
    email_id = models.EmailField(null = True, blank = True)
    timestamp = models.DateTimeField(default=timezone.now)
    def __str__(self):
        return self.email_id

class User_Mail(models.Model):
    user_id = models.IntegerField(blank=True,null=True)
    welcome_mail = models.BooleanField(default=False)
    day3_mail = models.BooleanField(default=False)
    day9_mail = models.BooleanField(default=False)
    day13_mail = models.BooleanField(default=False)
    Subscribed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

class User_Subscribe_Mail(models.Model):
    user_id = models.IntegerField(blank=True,null=True)
    Subscribed = models.BooleanField(default=False)
    start_date = models.DateTimeField(blank=True,null=True)
    expiry_date = models.DateTimeField(blank=True,null=True)
    product_id = models.CharField(max_length=200,blank=True,null=True)
    plan_id = models.CharField(max_length=200,blank=True,null=True)
    oneweek_ago = models.BooleanField(default=False)

class User_Details(models.Model):
    email_id = models.CharField(max_length=1000,blank=True,null=True)
    first_name = models.CharField(max_length=200,blank=True,null=True)
    last_name = models.CharField(max_length=200,blank=True,null=True)
    address1 = models.CharField(max_length=1000,blank=True,null=True)
    address2 = models.CharField(max_length=1000,blank=True,null=True)
    city = models.CharField(max_length=200,blank=True,null=True)
    territory = models.CharField(max_length=200,blank=True,null=True)
    postal_code = models.CharField(max_length=200,blank=True,null=True)
    country = models.CharField(max_length=200,blank=True,null=True)
    phone_number = models.CharField(max_length=200,blank=True,null=True)
    phone_code = models.CharField(max_length=200,blank=True,null=True)