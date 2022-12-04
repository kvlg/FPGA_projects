module DataCounter (Clock,Up,Reset,Down,SignSwitch,Data);
 parameter Size = 5, Signed = "No", Code = "Str";
 input  var bit  Clock;
 input  var logic Up, Reset, Down, SignSwitch;
 output var logic [Size-1:0] Data = 0; // Binary

generate

 if (Signed == "No")
 always_ff @(posedge Clock)
 
 begin: unsigned_counter
  if (~Reset) begin Data <= 0; end 
  else if (Up)
  begin if (Data < 2**Size - 1) Data <= Data + 1; end
  else if (Down)
  begin if (Data != 0) Data <= Data - 1; end
 end: unsigned_counter
 
 else // [-Max, ..., -1, 0, 1, ..., Max] Sign.Magnitude
 always_ff @(posedge Clock)
 
 begin: signed_counter

  if (Code == "Str")      // STRAIGHT BINARY CODE
  begin
  
  if (~Reset) begin Data <= 0; end
  else if (SignSwitch) begin Data[Size-1] = ~Data[Size-1]; end
  else if (Up)
  begin
  if ((Data >= 0) && (Data < 2**(Size-1)-1))            // [ 0..+2]
  Data <= Data + 1;
  else if ((Data > 2**(Size-1)+1) && (Data < 2**Size))  // [-3..-2]
  Data <= Data - 1;
  else if (Data == 2**(Size-1)+1)                       // -1
  Data <= 0;
  end

  else if (Down)
  begin
  if ((Data > 0) && (Data < 2**(Size-1)))               // [+1..+3]
  Data <= Data - 1;
  else if ((Data > 2**(Size-1)) && (Data < 2**Size-1))  // [-1..-2]
  Data <= Data + 1;
  else if (Data == 0)                                   // 0
  Data <= 2**(Size-1)+1;
  end
  
  end
  
  else if (Code == "Inv")   // ONE'S COMPLEMENT CODE
  begin
  
  if (~Reset) begin Data <= 0; end
  else if (SignSwitch)
  begin
  Data[Size-1] = ~Data[Size-1];
  Data[Size-2:0] = 2**(Size-1) - Data[Size-2:0] - 1;
  end
  else if (Up)
  begin
  if (((Data >= 0) && (Data < 2**(Size-1)-1)) || ((Data >= 2**(Size-1)) && (Data < 2**Size-1)))   // [ 0..+2] || [-3..-2]
  Data <= Data + 1;
  else if (Data == 2**Size-1)                       // -1
  Data <= 0;
  end

  else if (Down)
  begin
  if (((Data > 0) && (Data < 2**(Size-1))) || ((Data > 2**(Size-1)) && (Data < 2**Size)))       // [+1..+3] || [-1..-2]
  Data <= Data - 1;
  else if (Data == 0)                               // 0
  Data <= 2**Size-1;
  end
  
  end

  else                        // TWO'S COMPLEMENT CODE
  begin
  
  if (~Reset) begin Data <= 0; end
  else if ((SignSwitch) && (Data != 0))
  begin
  Data[Size-1] = ~Data[Size-1];
  Data[Size-2:0] = 2**(Size-1) - Data[Size-2:0];
  end
  else if (Up)
  begin
  if (((Data >= 0) && (Data < 2**(Size-1)-1)) || ((Data >= 2**(Size-1)) && (Data < 2**Size-1))) // [ 0..+2] || [-3..-2]
  Data <= Data + 1;
  else if (Data == 2**Size-1)                       // -1
  Data <= 0;
  end

  else if (Down)
  begin
  if (((Data > 0) && (Data < 2**(Size-1))) || ((Data > 2**(Size-1)+1) && (Data < 2**Size)))       // [+1..+3] || [-1..-2]
  Data <= Data - 1;
  else if (Data == 0)                               // 0
  Data <= 2**Size-1;
  end
  
  end
    
 end: signed_counter
 endgenerate
 endmodule: DataCounter
