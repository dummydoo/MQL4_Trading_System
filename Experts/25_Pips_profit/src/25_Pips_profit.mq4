#property copyright     "Copyright 2016, Slawomir Chowanski, MIT License"
#property link          "http://chowanski.com.pl"
#property version       "1.00"
#property strict

#define profit 25

int g_digits = (int)MarketInfo(Symbol(), MODE_DIGITS);

int OnInit(){
   // Nic nie robi. Nothing to do. (void)
   return(INIT_SUCCEEDED);
  }
  
void OnDeinit(const int reason){
   // Nic nie robi. Nothing to do. (void)
  }

void OnTick(){

   bool order_modify_check = false;
   int counter = OrdersTotal();      

      for(  ; counter >= 0; counter--)
        {
            if(OrderSelect(counter, SELECT_BY_POS, MODE_TRADES) == true)
              {
		  // I dont have to check condition (OrderTakeProfit() == 0.00000 && OrderStopLoss() == 0.00000).
		  // I have to check only equals betwen them. It is only one situation when OrderTakeProfit() is equal OrderStopLoss().
		  // OrderTakeProfit() is equal OrderStopLoss() only when investor does not set this parametr in order.

		  // Buy order  - take profit is higher buy price, stop loss is less then buy price.
		  // Sell order - take profit is less sell price, stop loss is higher then sell price.

                  if((OrderType() == OP_BUY) && (OrderMagicNumber() == 0) && (OrderTakeProfit() == OrderStopLoss()))
                    {
                        order_modify_check = OrderModify(OrderTicket(),
                                             OrderOpenPrice(),
                                             OrderStopLoss(),
                                             NormalizeDouble(OrderOpenPrice() + profit *_Point, g_digits),
                                             OrderExpiration(),
                                             CLR_NONE);
                                             
                         if(order_modify_check == false)
                           {
                              Alert("Take profit is not set: ", OrderTicket());
                           }
                    }
                       
                   if((OrderType() == OP_SELL) && (OrderMagicNumber() == 0) && (OrderTakeProfit() == OrderStopLoss()))
                    {
                        order_modify_check = OrderModify(OrderTicket(),
                                             OrderOpenPrice(),
                                             OrderStopLoss(),
                                             NormalizeDouble(OrderOpenPrice() - profit *_Point, g_digits),
                                             OrderExpiration(),
                                             CLR_NONE);
                                             
                         if(order_modify_check == false)
                           {
                              Alert("Take profit is not set: ", OrderTicket());
                           }
                    }
              }  
        }
  }
