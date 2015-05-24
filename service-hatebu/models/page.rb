class Page

  include Mongoid::Document

  field :page_id, :type => Integer

  field :title, :type => String

  field :rank, :type => Float

  field :hatebu, :type => Integer

end
