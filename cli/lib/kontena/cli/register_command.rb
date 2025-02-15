class Kontena::Cli::RegisterCommand < Clamp::Command
  include Kontena::Cli::Common

  option "--auth-provider-url", "AUTH_PROVIDER_URL", "Auth provider URL"

  def execute
    auth_api_url = auth_provider_url || 'https://auth.kontena.io'
    if !auth_api_url.start_with?('http://') && !auth_api_url.start_with?('https://')
      auth_api_url = "https://#{auth_api_url}"
    end
    email = ask("Email: ")
    password = password("Password: ")
    password2 = password("Password again: ")
    if password != password2
      abort("Passwords don't match".colorize(:red))
    end
    params = {email: email, password: password}
    auth_client = Kontena::Client.new(auth_api_url)
    auth_client.post('users', params)
  end
end
