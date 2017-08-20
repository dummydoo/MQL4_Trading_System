#property copyright     "Copyright 2016, Slawomir Chowanski, MIT License"
#property link          "http://chowanski.com.pl"
#property version       "1.00"
#property strict

#define profit 25

// About this EA:
// The variable profit is setting on 25 pips.
// The variable magic number for opened orders is 0.
// 
// If OrderStopLoss() is equal OrderTakeProfit() and is equal 0.00000
// strategy i setting OrderTakeProfit on 25 pips and place the order.

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
