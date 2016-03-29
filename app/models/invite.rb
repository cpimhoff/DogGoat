class Invite < ActiveRecord::Base

  belongs_to :owner, class_name: "Member", foreign_key: "owner_id"

  EMAIL_RX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_uniqueness_of :claim_code, message: "claim code is not unique"
  validates_presence_of :claim_code
  validates_presence_of :owner_id, message: "Invites must be sent by a valid member."

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_format_of :email, with: EMAIL_RX, message: "Please provide a valid email address."
  validates_confirmation_of :email

  def full_name
    first_name + " " + last_name
  end

  def self.generate_code
    raw_lang = %w(0 1 2 3 4 5 6 7 8 9)
    spice_lang = %w(DOG GOAT BIT POP CAT ZIP BUN RED HOP WOW BUTT SUN ZOO 007 TOY FEW APE FROG STAR COW GYM SAO ABE GIN MAX MIN ZAP POW WIG DIP GOD SAW AXE QOC CUJ DEW LIT BOX BOP OBJ CPI DAN
      DIN RUB BUM GIT DEE NIP XXX)

    generated_code = ""
    until generated_code.length == 10
      if rand(2) == 1
        # add a spicy word if possible
        spicy_word = spice_lang[rand(spice_lang.count)]
        if (generated_code.length + spicy_word.length) < 10
          generated_code += spicy_word
        end
      else
        # add a raw letter
        raw_letter = raw_lang[rand(raw_lang.count)]
        generated_code += raw_letter
      end
    end

    return generated_code.upcase
  end

end
