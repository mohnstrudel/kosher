class LabelSerializer < ActiveModel::Serializer
  attributes :id, :logo, :title, :description, :created_at, :updated_at, :sub_labels

  has_many :products

  def sub_labels
    my_hash = Hash.new
    object.sub_labels.map do |sub_label| 
      {
        id: sub_label.id,
        title: sub_label.title,
        logo: sub_label.logo
      }
    end    
  end

  # def sub_labels
  #   object.sub_labels.pluck(:id, :title, :logo)
  # end
end
