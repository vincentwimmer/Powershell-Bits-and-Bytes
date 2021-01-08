  
Write-Host @"
Welcome to Quick-Stock-DD-Resources V1.1.1
This script utilizes Google Chrome and will find the input Stock ticker on:
SEC, Barchart, MarcroAxis, WolframAlpha, Seeking Alpha, Google News, Reddit, 
MarketWatch, and TradingView.
And google search terms for:
Bankruptcy, Layoffs, Buybacks, and Repurchases.
----------------------------------------------------------------------------
"@

while ($true) {
$Ticker = Read-Host "Enter Ticker"

Write-Host "Firing Cannons.."

#SEC
start-process "chrome.exe" "https://www.sec.gov/cgi-bin/browse-edgar?CIK=$Ticker&action=getcompany&owner=exclude",'--profile-directory="Default"'

#Barchart Overview
start-process "chrome.exe" "https://www.barchart.com/stocks/quotes/$Ticker/overview",'--profile-directory="Default"'

#Barchart Options
start-process "chrome.exe" "https://www.barchart.com/stocks/quotes/$Ticker/options",'--profile-directory="Default"'

#MacroAxis
start-process "chrome.exe" "https://www.macroaxis.com/invest/market/$Ticker",'--profile-directory="Default"'

#WolframAlpha
start-process "chrome.exe" "https://www.wolframalpha.com/input/?i=$Ticker",'--profile-directory="Default"'

#Seeking Alpha
start-process "chrome.exe" "https://seekingalpha.com/symbol/$Ticker",'--profile-directory="Default"'

#Google News
start-process "chrome.exe" "https://news.google.com/search?q=$Ticker",'--profile-directory="Default"'

#Google Bankruptcy
start-process "chrome.exe" "https://www.google.com/search?q=$Ticker+Bankruptcy",'--profile-directory="Default"'

#Google Layoffs
start-process "chrome.exe" "https://www.google.com/search?q=$Ticker+Layoffs",'--profile-directory="Default"'

#Google BuyBack
start-process "chrome.exe" "https://www.google.com/search?q=$Ticker+Buyback",'--profile-directory="Default"'

#Google Repurchase
start-process "chrome.exe" "https://www.google.com/search?q=$Ticker+Repurchase",'--profile-directory="Default"'

#r/WSB
start-process "chrome.exe" "https://www.reddit.com/r/wallstreetbets/search/?q=$Ticker&include_over_18=on&restrict_sr=on&t=all&sort=new",'--profile-directory="Default"'

#r/Stocks
start-process "chrome.exe" "https://www.reddit.com/r/stocks/search/?q=$Ticker&include_over_18=on&restrict_sr=on&t=all&sort=new",'--profile-directory="Default"'

#MarketWarch
start-process "chrome.exe" "https://www.marketwatch.com/investing/stock/$Ticker",'--profile-directory="Default"'

#TradingView
start-process "chrome.exe" "https://www.tradingview.com/symbols/$Ticker/",'--profile-directory="Default"'

Write-Host @"
Another One?
"@
}
