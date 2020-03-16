class Report < ApplicationRecord
  #after_create :run_analysis

  belongs_to :account

  #def process()



end
