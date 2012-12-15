ig.module('game.entities.gui.textBox').requires('game.entities.gui.rectangle').defines ->
  window.EntityTextBox = EntityRectangle.extend(
    font: new ig.Font('media/helvetica24000.png')

    init: (x, y, settings) ->
      @parent(x, y, settings)
      @text = settings.text
      @splitLines(@text, @font, @width)
      @fontHeight = @font.height*4/5
    draw: ->
      @parent()
      @drawText(@allLines)

    drawText: (text) ->
      for i in [0...text.length]
        line = text[i]
        @font.draw(line, @x, @y + i*@fontHeight, ig.Font.ALIGN.LEFT)

    #this method taken from a blog post at http://liza.io/
    splitLines: (text,font,maxTextWidth) ->
      words = text.split(' ');
      lastWord = words[words.length - 1];
      lineWidth = 0;
      wordWidth = 0;
      @thisLine = '';
      @allLines = new Array();

      for i in [0..words.length]
        word = words[i];
        @thisLine = @thisLine.concat(word + ' ') unless word is ''
        lineWidth = @font.widthForString(@thisLine)
        if (word isnt lastWord)
          nextWord = words[i + 1];

          if (lineWidth + @font.widthForString(nextWord) >= maxTextWidth)
            @addToAllLines(@thisLine);
          else if (word is '~')
            @addToAllLines(' ');
          else if (nextWord is '~')
            @addToAllLines(@thisLine);

        else
          @addToAllLines(@thisLine);
          return @allLines;

    addToAllLines: (text) ->
      @allLines.push(text);
      @thisLine = '';
  )

