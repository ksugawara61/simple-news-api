require 'logger'

# ログ出力用
APP_LOG_PATH = './logs/application.log'
DEV_LOG_PATH = './logs/development.log'
ERR_LOG_PATH = './logs/error.log'
APP_LOGGER = Logger.new(APP_LOG_PATH)
DEV_LOGGER = Logger.new(DEV_LOG_PATH)
ERR_LOGGER = Logger.new(ERR_LOG_PATH)

module NewsLogger
  module_function
  # アプリケーションログ出力用関数
  # @param  [String] message  出力する文字列
  def app_logging(message)
    logger = APP_LOGGER
    logger.info message
  end

  # 開発用ログ出力用関数
  # @param  [String] message  出力する文字列
  def dev_logging(message)
    logger = DEV_LOGGER
    logger.debug message
  end

  # エラーログ出力用関数
  # @param  [None] exception  例外
  def err_logging(exception)
    logger = ERR_LOGGER
    logger.error caller[0][/`([^']*)'/, 1]
    logger.error exception.class
    logger.error "Error message => #{exception.message}"
    logger.error "#{exception.backtrace.join("\n")}"
  end

  # エラーログ出力用関数
  # @param  [String] message  出力する文字列
  def err_logging(message)
    logger = ERR_LOGGER
    logger.error message
  end
end
