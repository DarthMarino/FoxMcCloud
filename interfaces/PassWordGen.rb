require 'fox16'
include Fox

NUMBERS = (1..9).to_a
ALPHABET_LOWER = ("a".."z").to_a
ALPHABET_UPPER = ("A".."Z").to_a
ALL_POSSIBLE_CHARS = (33..126).map{|a| a.chr}

class PasswordGenerator < FXMainWindow
  def initialize(app)
    super(app, "Password generator", :width => 400, :height => 200)

    hFrame1 = FXHorizontalFrame.new(self)
    chrLabel = FXLabel.new(hFrame1, "Number of characters in password:")
    chrTextField = FXTextField.new(hFrame1, 4)

    hFrame2 = FXHorizontalFrame.new(self)
    specialChrsCheck = FXCheckButton.new(hFrame2, "Include special characters in password")

    vFrame1 = FXVerticalFrame.new(self, :opts => LAYOUT_FILL)
    textArea = FXText.new(vFrame1, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)

    hFrame3 = FXHorizontalFrame.new(vFrame1)
    generateButton = FXButton.new(hFrame3, "Generate")
    copyButton = FXButton.new(hFrame3, "Copy to clipboard")

    generateButton.connect(SEL_COMMAND) do
      textArea.removeText(0, textArea.length)
      textArea.appendText(generatePassword(chrTextField.text.to_i, ALL_POSSIBLE_CHARS))
    end
  end

  def generatePassword(pwLength, charArray)
    len = charArray.length
    (1..pwLength).map do
      charArray[rand(len)]
    end.join
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if FILE == $0
  FXApp.new do |app|
    PasswordGenerator.new(app)
    app.create
    app.run
  end
end
