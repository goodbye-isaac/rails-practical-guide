class Task < ApplicationRecord
	validates :name, presence: true, length: {maximum: 30}
	validate :validate_name_not_including_comma
	belongs_to :user
	# ActiveStorageの設定、タスクに画像を添付できるようにしてる
	has_one_attached :image

	# ransackの検索可能なカラム指定
	def self.ransackable_attributes(auth_object = nil)
		%w[name created_at]
	end
	def self.ransackable_associations(auth_object = nil)
		[]
	end

	private
	def validate_name_not_including_comma
		self.errors.add(:name,'にカンマを含めることはできません') if name&.include?(',')
	end
end 