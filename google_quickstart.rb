require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/storage'
require 'google/api_client/auth/storages/file_store'
require 'fileutils'

APPLICATION_NAME = 'Mechacoach'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                             "script-ruby-quickstart.json")
SCOPE = 'https://www.googleapis.com/auth/drive'

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization request via InstalledAppFlow.
# If authorization is required, the user's default browser will be launched
# to approve the request.
#
# @return [Signet::OAuth2::Client] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  file_store = Google::APIClient::FileStore.new(CREDENTIALS_PATH)
  storage = Google::APIClient::Storage.new(file_store)
  auth = storage.authorize

  if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
    app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)
    flow = Google::APIClient::InstalledAppFlow.new({
      :client_id => app_info.client_id,
      :client_secret => app_info.client_secret,
      :scope => SCOPE})
    auth = flow.authorize(storage)
    puts "Credentials saved to #{CREDENTIALS_PATH}" unless auth.nil?
  end
  auth
end

# Initialize the API
client = Google::APIClient.new(:application_name => APPLICATION_NAME)
client.authorization = authorize
SCRIPT_ID = 'ENTER_YOUR_SCRIPT_ID_HERE'
script_api = client.discovered_api('script', 'v1')

# Create an execution request object.
request = {
  :function => 'getFoldersUnderRoot'
}

begin
  # Make the API request.
  resp = client.execute!(
    :api_method => script_api.scripts.run,
    :body_object => request,
    :parameters => {
      :scriptId => SCRIPT_ID })

  if resp.data.error
    # The API executed, but the script returned an error.

    # Extract the first (and only) set of error details. The values of this
    # object are the script's 'errorMessage' and 'errorType', and an array of
    # stack trace elements.
    error = resp.data.error.details[0]
    puts "Script error message: #{error.errorMessage}"

    if error.scriptStackTraceElements
      # There may not be a stacktrace if the script didn't start executing.
      puts "Script error stacktrace:"
      error.scriptStackTraceElements.each do |trace|
        puts "\t#{trace['function']}: #{trace['lineNumber']}"
      end
    end
  else
    # The structure of the result will depend upon what the Apps Script function
    # returns. Here, the function returns an Apps Script Object with String keys
    # and values, and so the result is treated as a Ruby hash (folderSet).
    folderSet = resp.data.response.result
    if folderSet.length == 0
      puts "No folders returned!"
    else
      puts "Folders under your root folder:"
      folderSet.each do |id, folder|
        puts "\t#{folder} (#{id})"
      end
    end
  end
rescue Google::APIClient::ClientError
  # The API encountered a problem before the script started executing.
  puts "Error calling API!"
end
