# Dot Matrix Display

Dot Matrix LED Display, known from your DIY electronics craft box</br>

Key is the core DotMatrixDisplay widget which properties are:<br/>
|Property|Description|
|----|----|
|foreground|Color for dots (MaterialColor)|
|frameColor|Color of surrounding frame (MaterialColor)|
|frameBackgroundColor|Background color on which dots will be painted (MaterialColor)|
|frameWidth|Width of the surrounding frame (double)|
|dotSize|Size of the dots (double)|
|scaleFactor|Scaling of the whole digit to display: 0 - 1.0, 100% = (x: 400, y:600)|
</br>
The size of the entire Dot Matrix is taken from superior parent widget, calculated by MediaQuery package.</br>
