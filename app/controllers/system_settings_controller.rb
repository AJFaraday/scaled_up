#
# SystemSettingsController is slightly non-standard. 
# Every action works on all settings. 
# There will only ever be a handful of settings, defined by config/system_settings.yml
# and created on rake db:seed.rb
#


class SystemSettingsController < ApplicationController

  before_action :check_local_request
  before_action :get_system_settings

  def index
    
  end

  def edit
 
  end

  def update
    @system_settings.each do |setting|
      setting_param = params[setting.name]
      if setting_param and !setting_param.blank?
        setting.update_attribute(:value, setting_param)
      end
    end 
    flash[:success] = "The populated settings were updated."
    redirect_to edit_system_settings_path
  end 

  protected 

  def get_system_settings
    @system_settings = SystemSetting.order('id asc').all
  end 

end
