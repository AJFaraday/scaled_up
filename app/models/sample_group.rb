class SampleGroup < ActiveRecord::Base

  has_many :samples

  has_many :event_profiles

  validates_uniqueness_of :name

  def SampleGroup.create_from_hash(hash)
    hash.each do |sample_group_name,sample_names|
      puts "SampleGroup: #{sample_group_name}"
      sample_group = SampleGroup.find_by_name(sample_group_name)
      sample_group ||= SampleGroup.create!(name: sample_group_name)

      sample_names.each do |display_name, name|
        puts " Sample: #{display_name}"
        unless sample_group.samples.find_by_display_name(display_name)
          sample_group.samples.create!(
            display_name: display_name,
            name: name
          )
        end
      end
    end
  end 

end
