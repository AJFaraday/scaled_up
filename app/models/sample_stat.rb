class SampleStat < ActiveRecord::Base

  def SampleStat.bar_data
    stats = SampleStat.all.order('name asc')
    data = {
      labels: stats.collect{|x|x.name},
      datasets: [
        {
          fillColor: '#FFFFFF',
          strokeColor: '#000000',
          data: stats.collect{|x|x.cnt}          
        }
      ]
    }
    data.to_json
  end

end
