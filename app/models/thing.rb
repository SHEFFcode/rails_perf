class Thing < ActiveRecord::Base
  has_many :minions
end

# performance_development=# select pg_size_pretty(pg_relation_size('things'));
#  pg_size_pretty 
# ----------------
#  11 MB, so we are dealing with an 11 MB DB


# Measure.run(gc: :disable) { Thing.all.load }
# {"2.7.0":{"gc":"disable","time":0.15,"gc_count":0,"memory":"23 MB"}}
# Loading all actually allocates about 23 MB, or double the memory

# Measure.run(gc: :disable) {Thing.all.select(:id, :col1, :col5).load}
# {"2.7.0":{"gc":"disable","time":0.07,"gc_count":0,"memory":"13 MB"}}