class LabelSimpleSerializer < ActiveModel::Serializer
  attributes :id, :logo, :title, :description, :sublabels

  def sublabels
    my_hash = Hash.new
    object.sub_labels.map do |sub_label| 
      {
        id: sub_label.id,
        attributes: {
          title: sub_label.title,
          logo: sub_label.logo
        }
      }
    end    
  end

  # def sub_labels
  #   object.sub_labels.pluck(:id, :title, :logo)
  # end
end
