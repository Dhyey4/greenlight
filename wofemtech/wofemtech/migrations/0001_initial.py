from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Users',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('room_id', models.IntegerField(blank=True, null=True)),
                ('provider', models.CharField(blank=True, max_length=1000, null=True)),
                ('uid', models.CharField(blank=True, max_length=1000, null=True)),
                ('name', models.CharField(blank=True, max_length=1000, null=True)),
                ('username', models.CharField(blank=True, max_length=1000, null=True)),
                ('email', models.CharField(blank=True, max_length=1000, null=True, unique=True)),
                ('social_uid', models.CharField(blank=True, max_length=1000, null=True)),
                ('image', models.CharField(blank=True, max_length=1000, null=True)),
                ('password', models.CharField(db_column='password_digest', max_length=100)),
                ('accepted_terms', models.BooleanField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
                ('language', models.CharField(blank=True, max_length=1000, null=True)),
                ('reset_digest', models.CharField(blank=True, max_length=1000, null=True)),
                ('reset_sent_at', models.DateTimeField(blank=True, null=True)),
                ('activation_digest', models.CharField(blank=True, max_length=1000, null=True)),
                ('deleted', models.BooleanField()),
                ('role_id', models.BigIntegerField(blank=True, null=True)),
                ('last_login', models.DateTimeField(blank=True, db_column='activated_at', null=True)),
                ('is_superuser', models.BooleanField(blank=True, db_column='email_verified', null=True)),

                ('is_staff', models.BooleanField(default=False, null=True)),
                ('forgot_password', models.BooleanField(default=False)),

            ],
            options={
                'db_table': 'users',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ArInternalMetadata',
            fields=[
                ('key', models.CharField(max_length=1000, primary_key=True, serialize=False)),
                ('value', models.CharField(blank=True, max_length=1000, null=True)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'db_table': 'ar_internal_metadata',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Features',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('setting_id', models.IntegerField(blank=True, null=True)),
                ('name', models.CharField(max_length=1000)),
                ('value', models.CharField(blank=True, max_length=1000, null=True)),
                ('enabled', models.BooleanField(blank=True, null=True)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'db_table': 'features',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Invitations',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('email', models.CharField(max_length=1000)),
                ('provider', models.CharField(max_length=1000)),
                ('invite_token', models.CharField(blank=True, max_length=1000, null=True)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'db_table': 'invitations',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='RolePermissions',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, max_length=1000, null=True)),
                ('value', models.CharField(blank=True, max_length=1000, null=True)),
                ('enabled', models.BooleanField(blank=True, null=True)),
                ('role_id', models.IntegerField(blank=True, null=True)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'db_table': 'role_permissions',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Roles',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, max_length=1000, null=True)),
                ('priority', models.IntegerField(blank=True, null=True)),
                ('can_create_rooms', models.BooleanField(blank=True, null=True)),
                ('send_promoted_email', models.BooleanField(blank=True, null=True)),
                ('send_demoted_email', models.BooleanField(blank=True, null=True)),
                ('can_edit_site_settings', models.BooleanField(blank=True, null=True)),
                ('can_edit_roles', models.BooleanField(blank=True, null=True)),
                ('can_manage_users', models.BooleanField(blank=True, null=True)),
                ('colour', models.CharField(blank=True, max_length=1000, null=True)),
                ('provider', models.CharField(blank=True, max_length=1000, null=True)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
                ('user_limit', models.IntegerField(blank=True, null=True)),
                ('time_limit', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'roles',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Rooms',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('user_id', models.IntegerField(blank=True, null=True)),
                ('name', models.CharField(blank=True, max_length=1000, null=True)),
                ('uid', models.CharField(blank=True, max_length=1000, null=True)),
                ('bbb_id', models.CharField(blank=True, max_length=1000, null=True)),
                ('sessions', models.IntegerField(blank=True, null=True)),
                ('last_session', models.DateTimeField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
                ('room_settings', models.CharField(blank=True, max_length=1000, null=True)),
                ('moderator_pw', models.CharField(blank=True, max_length=1000, null=True)),
                ('attendee_pw', models.CharField(blank=True, max_length=1000, null=True)),
                ('access_code', models.CharField(blank=True, max_length=1000, null=True)),
                ('deleted', models.BooleanField()),
            ],
            options={
                'db_table': 'rooms',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='SchemaMigrations',
            fields=[
                ('version', models.CharField(max_length=1000, primary_key=True, serialize=False)),
            ],
            options={
                'db_table': 'schema_migrations',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Settings',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('provider', models.CharField(max_length=1000)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'db_table': 'settings',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='SharedAccesses',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('room_id', models.IntegerField(blank=True, null=True)),
                ('user_id', models.IntegerField(blank=True, null=True)),
                ('created_at', models.DateTimeField()),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'db_table': 'shared_accesses',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='UsersRoles',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField(blank=True, null=True)),
                ('role_id', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'users_roles',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField(blank=True, null=True)),
                ('product_id', models.CharField(blank=True, max_length=200, null=True)),
                ('plan_id', models.CharField(blank=True, max_length=200, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='DemoRequest',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=200, null=True)),
                ('email', models.CharField(blank=True, max_length=200, null=True)),
                ('phone_number', models.CharField(blank=True, max_length=200, null=True)),
                ('country', models.CharField(blank=True, max_length=200, null=True)),
                ('commpany_name', models.CharField(blank=True, max_length=200, null=True)),
                ('employee', models.CharField(blank=True, max_length=200, null=True)),
                ('prefered_date', models.DateField(blank=True, null=True)),
                ('prefered_time', models.TimeField(blank=True, null=True)),
                ('information', models.TextField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='ProductDescription',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product', models.CharField(blank=True, max_length=200, null=True)),
                ('description', models.TextField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Subscribe',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('email_id', models.EmailField(blank=True, max_length=254, null=True)),
                ('timestamp', models.DateTimeField(default=django.utils.timezone.now)),
            ],
        ),
        migrations.CreateModel(
            name='User_Mail',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField(blank=True, null=True)),
                ('welcome_mail', models.BooleanField(default=False)),
                ('day3_mail', models.BooleanField(default=False)),
                ('day9_mail', models.BooleanField(default=False)),
                ('day13_mail', models.BooleanField(default=False)),
                ('Subscribed', models.BooleanField(default=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='User_Subscribe_Mail',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField(blank=True, null=True)),
                ('Subscribed', models.BooleanField(default=False)),
                ('start_date', models.DateTimeField(blank=True, null=True)),
                ('expiry_date', models.DateTimeField(blank=True, null=True)),
                ('product_id', models.CharField(blank=True, max_length=200, null=True)),
                ('plan_id', models.CharField(blank=True, max_length=200, null=True)),
                ('oneweek_ago', models.BooleanField(default=False)),
                ('expired', models.BooleanField(default=False)),
            ],
        ),
    ]
