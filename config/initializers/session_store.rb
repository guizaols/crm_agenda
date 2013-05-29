# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_contabilidade_session',
  :secret      => '055393ba8560f664cc4446fe0ff925278cd177ce7a85a36612f19a508499cd4925fdf0dd9467e2af89fc85462446d8a1b1ce3411401209c5d793a80588f12b66'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
