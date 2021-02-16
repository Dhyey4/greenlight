# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class ArInternalMetadata(models.Model):
    key = models.CharField(primary_key=True, max_length=-1)
    value = models.CharField(max_length=-1, blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ar_internal_metadata'


class Features(models.Model):
    id = models.BigAutoField(primary_key=True)
    setting_id = models.IntegerField(blank=True, null=True)
    name = models.CharField(max_length=-1)
    value = models.CharField(max_length=-1, blank=True, null=True)
    enabled = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'features'


class Invitations(models.Model):
    id = models.BigAutoField(primary_key=True)
    email = models.CharField(max_length=-1)
    provider = models.CharField(max_length=-1)
    invite_token = models.CharField(max_length=-1, blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'invitations'


class RolePermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=-1, blank=True, null=True)
    value = models.CharField(max_length=-1, blank=True, null=True)
    enabled = models.BooleanField(blank=True, null=True)
    role_id = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'role_permissions'


class Roles(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=-1, blank=True, null=True)
    priority = models.IntegerField(blank=True, null=True)
    can_create_rooms = models.BooleanField(blank=True, null=True)
    send_promoted_email = models.BooleanField(blank=True, null=True)
    send_demoted_email = models.BooleanField(blank=True, null=True)
    can_edit_site_settings = models.BooleanField(blank=True, null=True)
    can_edit_roles = models.BooleanField(blank=True, null=True)
    can_manage_users = models.BooleanField(blank=True, null=True)
    colour = models.CharField(max_length=-1, blank=True, null=True)
    provider = models.CharField(max_length=-1, blank=True, null=True)
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
    name = models.CharField(max_length=-1, blank=True, null=True)
    uid = models.CharField(max_length=-1, blank=True, null=True)
    bbb_id = models.CharField(max_length=-1, blank=True, null=True)
    sessions = models.IntegerField(blank=True, null=True)
    last_session = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()
    room_settings = models.CharField(max_length=-1, blank=True, null=True)
    moderator_pw = models.CharField(max_length=-1, blank=True, null=True)
    attendee_pw = models.CharField(max_length=-1, blank=True, null=True)
    access_code = models.CharField(max_length=-1, blank=True, null=True)
    deleted = models.BooleanField()

    class Meta:
        managed = False
        db_table = 'rooms'


class SchemaMigrations(models.Model):
    version = models.CharField(primary_key=True, max_length=-1)

    class Meta:
        managed = False
        db_table = 'schema_migrations'


class Settings(models.Model):
    id = models.BigAutoField(primary_key=True)
    provider = models.CharField(max_length=-1)
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


class Users(models.Model):
    id = models.BigAutoField(primary_key=True)
    room_id = models.IntegerField(blank=True, null=True)
    provider = models.CharField(max_length=-1, blank=True, null=True)
    uid = models.CharField(max_length=-1, blank=True, null=True)
    name = models.CharField(max_length=-1, blank=True, null=True)
    username = models.CharField(max_length=-1, blank=True, null=True)
    email = models.CharField(max_length=-1, blank=True, null=True)
    social_uid = models.CharField(max_length=-1, blank=True, null=True)
    image = models.CharField(max_length=-1, blank=True, null=True)
    password_digest = models.CharField(unique=True, max_length=-1, blank=True, null=True)
    accepted_terms = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()
    email_verified = models.BooleanField(blank=True, null=True)
    language = models.CharField(max_length=-1, blank=True, null=True)
    reset_digest = models.CharField(max_length=-1, blank=True, null=True)
    reset_sent_at = models.DateTimeField(blank=True, null=True)
    activation_digest = models.CharField(max_length=-1, blank=True, null=True)
    activated_at = models.DateTimeField(blank=True, null=True)
    deleted = models.BooleanField()
    role_id = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users'


class UsersRoles(models.Model):
    user_id = models.IntegerField(blank=True, null=True)
    role_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users_roles'
