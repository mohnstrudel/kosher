class Faq < ApplicationRecord

  translates :question, :answer
  globalize_accessors :locales => [:en, :ru], :attributes => [:question, :answer]
end
