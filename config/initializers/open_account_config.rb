#The account plugin needs to be configured.  The following values may be used to customize the account

# Source address for user emails
OpenAccount::OpenAccountConfiguration.set_config :email_from, 'from@example.com'

# Destination email for system errors
OpenAccount::OpenAccountConfiguration.set_config :admin_email, 'admin@example.com'

# Sent in emails to users
OpenAccount::OpenAccountConfiguration.set_config :app_url, 'http://localhost:3000/'

# Sent in emails to users
OpenAccount::OpenAccountConfiguration.set_config :app_name, 'open'

# Email charset
OpenAccount::OpenAccountConfiguration.set_config :mail_charset, 'utf-8'

# Security token lifetime in hours
OpenAccount::OpenAccountConfiguration.set_config :security_token_life_days, 24

# Two column form input
OpenAccount::OpenAccountConfiguration.set_config :two_column_input, true

# Add all changeable user fields to this array.
# They will then be able to be edited from the edit action. You
# should NOT include the email field in this array.
OpenAccount::OpenAccountConfiguration.set_config :changeable_fields, [ 'firstname', 'lastname' ]

# Set to true to allow delayed deletes (i.e., delete of record
# doesn't happen immediately after user selects delete account,
# but rather after some expiration of time to allow this action
# to be reverted).
OpenAccount::OpenAccountConfiguration.set_config :delayed_delete, false

# Default is one week
OpenAccount::OpenAccountConfiguration.set_config :delayed_delete_days, 7

OpenAccount::OpenAccountConfiguration.set_config :user_table, "users"

# controls whether or not email is used
OpenAccount::OpenAccountConfiguration.set_config :use_email_notification, false

# salt
OpenAccount::OpenAccountConfiguration.set_config :salt, "Put Salt Here - better yet use the salt.rb file for your salt.  Then don't check the salt.rb into your repository."