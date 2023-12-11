extends Node
var WheelOneValue=0
var WheelTwoValue=0
var WheelThreeValue=0
var rng = RandomNumberGenerator.new()

var hiddenBank = 0

var moneyValue=1000

var WeightValues = [10,20,10,20,50,100,300,1000]

var IconFrames = [2,0,14,12,10,8,6,4]

# Called when the node enters the scene tree for the first time.
func _ready():
	$HiddenBank.text = str(hiddenBank)
	$MoneyLabel.text = "$"+str(moneyValue)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func SpinWheels():
	SpinFirstWheel()
	SpinSecondWheel()
	SpinThirdWheel()

func SpinFirstWheel():
	var my_random_number = rng.randi_range(1, 8)
	WheelOneValue = my_random_number
	
func SpinSecondWheel():
	if rng.randi_range(0,1)==1:
		WheelTwoValue = WheelOneValue
		return
	WheelTwoValue =  RandomSymbolExcludeWheelOne()
	
func SpinThirdWheel():
	var weigtedBank=(hiddenBank/(WeightValues[WheelOneValue-1]))*100
	var winRoll = rng.randi_range(1,100)
	if winRoll<=weigtedBank || rng.randi_range(1,100)<=10:
		WheelThreeValue = WheelOneValue
		return
	WheelThreeValue = RandomSymbolExcludeWheelOne()
	
func RandomSymbolExcludeWheelOne():
	var existingNumber = WheelOneValue
	var newSymbol=rng.randi_range(1,8)
	if newSymbol == existingNumber:
		newSymbol-=1
	if newSymbol<=0:
		newSymbol=8
	return newSymbol
		


func _on_button_pressed():
	if moneyValue-10>=0 && $Wheel3/Timer.time_left <= 0:
		hiddenBank+=10
		moneyValue-=10
		$Wheel1/AnimatedSprite2D.play("spin")
		$Wheel1/Timer.start()
		$Wheel2/AnimatedSprite2D.play("spin")
		$Wheel2/Timer.start()
		$Wheel3/AnimatedSprite2D.play("spin")
		$Wheel3/Timer.start()
		SpinWheels()

func _on_reset_button_pressed():
	moneyValue = 1000
	hiddenBank = 0
	$HiddenBank.text = str(hiddenBank)
	$MoneyLabel.text = "$"+str(moneyValue)
	$Win.text=""
	
func _on_Wheel3_timer_timeout():
	$Wheel3/AnimatedSprite2D.stop()
	$Wheel3/AnimatedSprite2D.frame=IconFrames[WheelThreeValue-1]
	if WheelOneValue == WheelTwoValue && WheelOneValue == WheelThreeValue:
		moneyValue += WeightValues[WheelOneValue-1]
		hiddenBank -= WeightValues[WheelOneValue-1]
		$Win.text="+$"+str(WeightValues[WheelOneValue-1])
		$Win.set("theme_override_colors/font_color", Color(0, 1, 0))
	else:
		$Win.text="-$10"
		$Win.set("theme_override_colors/font_color", Color(1, 0, 0))
	$HiddenBank.text = str(hiddenBank)
	$MoneyLabel.text = "$"+str(moneyValue)

func _on_Wheel2_timer_timeout():
	$Wheel2/AnimatedSprite2D.stop()
	$Wheel2/AnimatedSprite2D.frame=IconFrames[WheelTwoValue-1]

func _on_Wheel1_timer_timeout():
	$Wheel1/AnimatedSprite2D.stop()
	$Wheel1/AnimatedSprite2D.frame=IconFrames[WheelOneValue-1]