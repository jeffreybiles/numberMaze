ig.module('game.entities.gui.textBox').requires('game.entities.gui.rectangle').defines ->
  window.EntityTextBox = EntityRectangle.extend(
    init: (x, y, settings) ->
      @parent(x, y, settings)
      @text = settings.text
      @ctx.textAlign = 'left'
      @ctx.textBaseline = 'top'
      @ctx.font = "20pt Arial"

    draw: ->
      @parent()
      @ctx.fillStyle = 'black'
      @drawText()

    drawText: ->
      @ctx.fillText(@text, @x, @y)

    # splitLines: (text,font,maxTextWidth) ->
    #   words = text.split(' ');
    #   lastWord = words[words.length - 1];
    #   lineWidth = 0;
    #   wordWidth = 0;
    #   thisLine = '';
    #   allLines = new Array();

    #   for ( i = 0; i < words.length; i++) {
    #     word = words[i];
    #     thisLine = thisLine.concat(word + ' ');
    #     lineWidth = font.getWidth(thisLine);
    #     if (word !== lastWord)
    #       nextWord = words[i + 1];

    #       if (lineWidth + font.getWidth(nextWord) >= maxTextWidth)
    #         addToAllLines(thisLine);

    #       else if (word === '~')
    #         addToAllLines(' ');

    #       else if (nextWord === '~')
    #         addToAllLines(thisLine);

    #     else
    #       addToAllLines(thisLine);
    #       return allLines;

    # addToAllLines: (text) ->
    #   allLines.push(text);
    #   thisLine = '';
    #   lineWidth = 0;
  )

