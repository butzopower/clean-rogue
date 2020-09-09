module Views
  class Title
    def initialize(choice)
      @choice = choice
    end

    def contents
      [
          "  =======================",
          "  =    Clean   Rogue    =",
          "  =======================",
          "",
          "  - Press c to change controls:",
          "     #{standard_option}",
          "     #{vim_option}",
          "",
          "  - Press Enter to start",
          "  - Press q to quit",
      ]
    end

    private

    def standard_option
      if @choice == :standard
        "* Standard"
      else
        "  Standard"
      end
    end

    def vim_option
      if @choice == :vim
        "* VIM"
      else
        "  VIM"
      end
    end
  end
end