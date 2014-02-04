module LoadDataExtension
  def load_data data
    self.transaction do
      association.destroy_all
      data.each do |data|
        association.concat class_constant.new_from_json(data)
      end
    end
  end

  def association
    proxy_association
  end

  def association_name
    association.reflection.name
  end

  def class_constant
    Object.const_get(association_name.to_s.singularize.classify)
  end
end