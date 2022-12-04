module Back2Normal (Clock,RawData,SignSwitch,Data,PWMData,Sign);
 parameter Size   = 4,
           Signed = "No",
			  Code   = "Str";
 localparam  ISize = (Signed == "No") ?
             Size : Size-1; 
 input  var bit Clock;
 input  var logic [Size-1:0] RawData;
 input  var logic SignSwitch;
 output var logic [Size-1:0] Data;
 output var logic [ISize-1:0] PWMData;
 output var logic Sign;
 
 generate
 
 if (Code == "Str" && Signed == "Yes")
 always @(posedge Clock)
 begin: straight_code
 Data = RawData;
 Sign = Data[Size-1];
 PWMData = Data[Size-2:0];
 end: straight_code
 
 else if (Code == "Inv" && Signed == "Yes")
 always @(posedge Clock)
 begin: inverted_code
 if (RawData >= 2**(Size-1))
 begin
 Data = 2**(Size)-RawData[Size-2:0]-1;
 Sign = Data[Size-1];
 PWMData = Data[Size-2:0];
 end
 else
 begin
 Data = RawData;
 Sign = Data[Size-1];
 PWMData = Data[Size-2:0];
 end
 end: inverted_code
 
 else if (Code == "Aug" && Signed == "Yes")
 always @(posedge Clock)
 begin: augmented_code
 if (RawData > 2**(Size-1))
 begin
 Data = 2**(Size)-RawData[Size-2:0];
 Sign = Data[Size-1];
 PWMData = Data[Size-2:0]; 
 end
 else
 begin
 Data = RawData;
 Sign = Data[Size-1];
 PWMData = Data[Size-2:0];
 end
 end: augmented_code
 
 else if (Signed == "No")
 always @(posedge Clock)
 begin: unsigned_code
 Data = RawData;
 Sign = 1;
 PWMData = Data; 
 end: unsigned_code
 
endgenerate

endmodule: Back2Normal