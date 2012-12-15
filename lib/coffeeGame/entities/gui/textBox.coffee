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

    splitLines: (text,font,maxTextWidth) ->
      words = text.split(' ');
      lastWord = words[words.length - 1];
      lineWidth = 0;
      wordWidth = 0;
      @thisLine = '';
      @allLines = new Array();

      for i in [0..words.length]
        word = words[i];
        @thisLine = @thisLine.concat(word + ' ');
        lineWidth = @font.widthForString(@thisLine)
        if (word isnt lastWord)
          console.log(word)
          nextWord = words[i + 1];

          if (lineWidth + @font.widthForString(@thisLine) >= maxTextWidth)
            @addToAllLines(@thisLine);
            console.log(@thisLine)

          else if (word is '~')
            @addToAllLines(' ');

          else if (nextWord is '~')
            @addToAllLines(@thisLine);
            console.log(@thisLine)

        else
          @addToAllLines(@thisLine);
          return @allLines;

    addToAllLines: (text) ->
      console.log(text)
      @allLines.push(text);
      console.log(@allLines)
      @thisLine = '';
      lineWidth = 0;
  )

