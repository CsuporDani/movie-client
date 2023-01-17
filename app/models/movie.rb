class Movie < ApplicationRecord
  # CONSTANTS
  # = CONFIG, SAMPLE = 0

  # INCLUDES, EXTENDS
  # = include
  # = extend

  # MODULE INITIALIZERS
  # = acts_as_paranoid

  # SERIALIZATIONS
  # = serialize :preferences, JSON

  # ENUM
  # = enum state: [ :first_state, :second_state ]

  # ATTR
  # = attr_(accessor,writer,reader)
  attr_accessor :poster_url

  # VALIDATIONS
  # = validates

  validates :title,   presence: true
  validates :tmdb_id, presence: true, uniqueness: true

  # ASSOCIATIONS
  # = has_many, ... (has_many :comments, [class_name: 'Comment']?, ..., dependent: [ :destroy, :nullify, :delete ])

  # NESTED_ATTRIBUTES
  # = accepts_nested_attributes_for :comments

  # SCOPES
  # = scope ...

  # CALLBACKS
  # = def hook; end; before_save :hook

  # CLASS METHODS
  # = def self.function; end; (class << self)?

  # INSTANCE METHODS
  # = def function; end;

  def poster_url
    @poster_url ||= poster_path.present? ? "https://image.tmdb.org/t/p/original#{poster_path}" : nil
  end

  # SERIALIZERS
  # = def json_as_akarmi options = nil; options ||= {}; as_json options.merge({ methods: [:id, :created_at, :__type], includes: { ... }}); end
end