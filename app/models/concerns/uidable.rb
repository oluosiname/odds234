# frozen_string_literal: true

module Uidable
  extend ActiveSupport::Concern

  included do
    before_create :set_uid
  end

  class_methods do
    def u_find(uid)
      find_by(uid: uid)
    end
  end

  private

  def set_uid
    self.uid = generate_uid
  end

  def generate_uid
    loop do
      random_uid = SecureRandom.base36(16).upcase
      break random_uid unless self.class.exists?(uid: random_uid)
    end
  end
end
