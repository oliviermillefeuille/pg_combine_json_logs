# PG Combine JSON Logs

This tool combines multiple log files with JSON entries. 
It assumes that each entry begins with a timestamp in this format: YYYY-MM-DD HH:MM:SS UTC (ISO 8601 format type)

## Run the tool

```bash
ruby combine_json_logs.rb tests/test_1.log tests/test_2.log tests/test_3.log                     
```

## Output

The results of will be printed on STDOUT.

See an example below:
```
2023-04-26 10:38:00 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
	some json 01
	some json 02
	some json 03
2023-04-26 10:38:10 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
2023-04-26 10:38:15 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  2
	some json 151
	some json 152
	some json 153
2023-04-26 10:38:19 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  2
	some json 20
2023-04-26 10:38:20 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
	some json 20
2023-04-26 10:38:30 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
2023-04-26 10:38:35 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  2
2023-04-26 10:38:37 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  3
	some json 371
	some json 372
2023-04-26 10:38:40 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
2023-04-26 10:38:45 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  2
2023-04-26 10:38:50 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
2023-04-26 10:38:55 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  2
	some json 551
	some json 552
2023-04-26 10:39:35 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  2
2023-04-26 10:41:00 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  3
	some json 001
	some json 002
2023-04-26 10:49:35 UTC:10.0.0.1(49662):x:y:[30353]:LOG:  1
```


