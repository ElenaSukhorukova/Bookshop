class Api::V1::ApplicationController < ApplicationController
  include Authorization

  add_flash_types :danger, :warning
end
