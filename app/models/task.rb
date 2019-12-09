class Task < ApplicationRecord
    validates :name, presence: true
    validate :validate_name_not_including_comma

    belongs_to :user

    scope :recent, -> {order(created_at: :desc)}

    private

    def set_nameless_name
        self.name = '名前なし' if name.blank?
    end

    def validate_name_not_including_comma
        errors.add(:name,'にカンマを含めることはできません') if name&.include?(',')
    end
end