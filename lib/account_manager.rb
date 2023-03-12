module AccountManager; end

Dir[File.join(__dir__, 'account_manager', '*.rb')].each { |f| require f }

DATA_PATH = File.expand_path('./data')
