%function takes in a single trade and returns whether it bought or sold
function [sold, bought,trade] = act(trade1)
sold = 0;
bought = 0;

%switch case checks which moving average is in question and retrieves
%relevant historical information
switch trade1.movingAvg1
    case '3 MA'
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [3], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '4 MA'
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [4], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '5 MA'
        %trade1.paramas.Symbol = ticker symbol
        %trade1.movingAvg = moving average
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [5], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '7 MA'
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [7], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '8 MA'
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [8], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '10 MA'
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [10], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '15 MA'
        avgValues1 = getMA(trade1.paramas.Symbol, 'simple', [15], 'BarSize',trade1.barSize, 'UseRTH',1);
end

switch trade1.movingAvg2
    case '3 MA'
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [3], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '4 MA'
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [4], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '5 MA'
        %trade1.paramas.Symbol = ticker symbol
        %trade1.movingAvg = moving average
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [5], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '7 MA'
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [7], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '8 MA'
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [8], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '10 MA'
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [10], 'BarSize',trade1.barSize, 'UseRTH',1);
    case '15 MA'
        avgValues2 = getMA(trade1.paramas.Symbol, 'simple', [15], 'BarSize',trade1.barSize, 'UseRTH',1);
end

%Gets the current information about the stock in question
current = IBMatlab('action', 'query', 'symbol', trade1.paramas.Symbol);

%sends the highs, lows and closes from the historical data to EMA() which
%returns the averages for each candle
disp(trade1.hold);
if trade1.hold == 1 %current.bidPrice < avgValues2(1) if trade1.openPos = 1
    if avgValues1(1) > avgValues2(1)
        trade1.paramas.Action = 'buy';
        %long short or none parameter then add if statement
	else
		trade1.paramas.Action = 'sell';
    end
    trade1.hold=trade1.hold -2;
end

%outer if statement checks to see whether you are trying to buy or sell
if strcmp(trade1.paramas.Action, 'buy')
    %disp statements just to print out the prices that are being compared
    disp('in buy')
    disp('bid ');
    disp(current.bidPrice);
    disp('averages1 ');
    disp(avgValues1(1));
    disp('averages2 ');
    disp(avgValues2(1));
    %if the current market price if above the most recent average then buy
    if avgValues1(1) > avgValues2(1)
        disp('bought');
        %IBMatlab statement is just taking the trade parameters which has
        %all the info needed to buy
        IBMatlab(trade1.paramas);
        
        %sets boolean value of bought
        bought = 1;
        trade1.hold= trade1.hold+1;
    else
        disp('did not buy');
    end
else
    %program will go in here if the action is 'sell'
    disp('bid ');
    disp(current.bidPrice);
    disp('averages1 ');
    disp(avgValues1(1));
    disp('averages2 ');
    disp(avgValues2(1));
    %if market value if less than the most recent candle average then sell
    if avgValues1(1) < avgValues2(1)
        disp('sold');
        IBMatlab(trade1.paramas);
        
        %sets boolean value of sold
        sold = 1;
        trade1.hold= trade1.hold+1;
    else
        disp('didnt sell');
    end
end
trade=trade1;
end
