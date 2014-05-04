class SystemSetting < ActiveRecord::Base

  def SystemSetting.create_from_config
    SystemSetting.destroy_all
    config = YAML.load_file('config/system_settings.yml')
    config.each do |name,attrs|
      setting = SystemSetting.new({name: name}.merge(attrs))
      setting.value = setting.default
      setting.save!
    end 
    SystemSetting.all
  end 

  def SystemSetting.get(name)
    SystemSetting.find_by_name(name).value
  end 

  def value 
    v = super
    case self.value_class
      when 'integer'
        v.to_i
      when 'float'
        v.to_f
      else
        v
    end 
  end 

end
