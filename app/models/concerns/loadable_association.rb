module LoadableAssociation
  extend ActiveSupport::Concern

  included do
    cattr_accessor :associations do
      []
    end
  end

  module ClassMethods
    def loads_association association
      has_many association, -> { extending LoadDataExtension }, dependent: :destroy
      self.associations << association
    end
  end
end