class User < ApplicationRecord
    ### Validations ###
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PASSWORD = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d\-_]{8,30}+\z/

    validates :name, {presence: true}
    validates :email, {presence: true,
                       uniqueness: true,
                       format: {with: VALID_EMAIL_REGEX, message: "Invalid."}}
    validates :password, {presence: true,
                          format: {with: VALID_PASSWORD, message: "Invalid."},
                          confirmation: true}
    validates :password_confirmation, {presence: true}

    ### Encryption ###
    attr_encrypted :email, key: 'This is a key that is 256 bits!!'
    attr_encrypted :password, key: 'This is a key that is 256 bits!!'

    before_save do
    self.search_key = generate_hash(self.email, self.password)
    end

    # Use this hash value for searching purpose (e.g. login)
    def generate_hash(*args)
    Digest::SHA3.hexdigest(args.join(''))

  end
end
