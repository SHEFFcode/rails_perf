class Minion < ActiveRecord::Base
  belongs_to :thing
end

# Measure.run() { Thing.all.each {|thing| thing.minions.load} }
# {"2.7.0":{"gc":"enable","time":8.96,"gc_count":15,"memory":"338 MB"}}


# Measure.run() { Thing.all.includes(:minions).load }
# {"2.7.0":{"gc":"enable","time":2.62,"gc_count":10,"memory":"203 MB"}}
# we saved a bunch of time and memory!

