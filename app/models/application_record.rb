class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ROLES = ['teacher','assistant']
end
