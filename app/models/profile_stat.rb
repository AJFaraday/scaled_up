class ProfileStat < ActiveRecord::Base

  self.primary_key = :name

  PIE_COLOURS = %w{
    #eeeeee
    #cccccc
    #aaaaaa
    #888888
    #666666
    #444444
    #222222
    #000000
  }

  def ProfileStat.pie_chart_data
    i = -1
    result = ProfileStat.order('cnt desc').collect do |stat|
      i += 1
      {
        color: PIE_COLOURS[i % PIE_COLOURS.length],
        value: stat.cnt
      }
    end
    result.to_json
  end


end
