//
// Copyright (c) 2012, Cisco Systems, Inc.
//
// Author: Herry Wang (hailwang@cisco.com)
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <curl/curl.h>

//char *url = "http://wmt-os.auto-sj5.com:8800/snowboard_100.wmv";
//char *url = "http://U11-220-4.se.wmt.auto-sj5.com/snowboard_100.wmv";

int end_of_stream = 0;
char url[PATH_MAX];
float speed = 1.0;
int verbose = 0;
long total_size = 0;

void print_help ()
{
	fprintf (stderr, "usage: \n");
	fprintf (stderr, "./programname -u URL -S 1.0 -V \n");
	fprintf (stderr, "-S: speed, it's optional\n");
	fprintf (stderr, "-V,verbose it's optional\n");
}
static size_t cb_data(void *ptr, size_t size, size_t nmemb, void *stream)
{
	/* we are not interested in the downloaded bytes itself,
	   so we only return the size we would have saved ... */ 
	(void)ptr;  /* unused */ 
	(void)stream; /* unused */ 
	if(verbose) {
		printf("-- Got data %lu Bytes -- \n", size * nmemb);

		fflush(stdout);
	}
	else { 
        //Just print one # char once we get one packet
		printf("#");
		fflush(stdout);
	}
	total_size += size * nmemb;
	if(verbose) printf("Total data %lu Bytes Downloaded \n", total_size);
	if((size_t)(size * nmemb) == 8 ) { 
        //FIXME, string should be extracted to comparing with EOS
		printf("\nEND of stream\n");
		end_of_stream = 1;
	}
	return (size_t)(size * nmemb);
}

struct ResponseHeader {
	char code[3];
	char client_id[11];
};
static size_t cb_header(void *ptr, size_t size, size_t nmemb, void *uptr)
{
	if(verbose) printf("-- Got header %lu Bytes -- \n",(size_t)(size * nmemb));
	struct ResponseHeader *rh = (struct ResponseHeader *) uptr;
	char c_id[11];
	c_id[10] = '\0';
	char *p;
	//printf("HEADER CONETNET: %s",ptr);
	if(p = strstr(ptr,"client-id=")) {
		char *p1;
		char *p2;
		int len =0;
		if(p2 = strchr(p,',')) {
			//printf(", is found");
			p1 = p2;
		} else if(p2 = strstr(p,"\r\n")) {
			p1 = p2;
			//printf(" \\r \\n is found");
		}
		len = p1 -p;
		len -= 10;//len of client-id=
		//printf("len of client id is %d \r\n",len);
		strncpy(c_id,p+10,len);
		c_id[len] = '\0';
		if(verbose) printf("client-id: %s",c_id);
		strcpy(rh->client_id,c_id);

	}
	return (size_t)(size * nmemb);
}
#define HANDLECOUNT 1
#define HTTP_HANDLE 0
int parse_cli(int argc, char *argv [])
{
	int rget_opt = 0;
	while((rget_opt = getopt(argc, argv, "Vu:S:")) != EOF)
	{
		switch (rget_opt)
		{
			case 'u': //URL
				if (!optarg) 
				{
					fprintf (stderr, "%s error: -u should be followed by string \r\n", __func__);
					return -1;
				}
				strcpy(url,optarg);
				break;
			case 'S':
				if (!optarg) {
					fprintf (stderr, "%s error: -s should be followed by string like 2.2 \r\n", __func__);
					return -1;
				}
				sscanf(optarg,"%f",&speed);
				break;
			case 'V':
				verbose = 1;
				break;
			default:
				fprintf (stderr, "%s error: \r\n", __func__);
				return -1;

		}
	}
	if (optind < argc)
	{
		fprintf (stderr, "%s error: non-option argv-elements: ", __func__);
		while (optind < argc)
			fprintf (stderr, "%s ", argv[optind++]);
		fprintf (stderr, "\n");
		print_help();
		return -1;
	}

	return 0;
}
int main(int argc, char*argv[])
{
	if (parse_cli (argc, argv) == -1)
	{
		fprintf (stderr,
				"%s - error: failed parsing of the command line.\n", __func__);
		return -1;
	}

	CURL *handles[HANDLECOUNT];
	CURLM *multi_handle;
	int still_running;
	CURLMsg *msg; /* for picking up messages with the transfer status */ 
	int msgs_left; /* how many messages are left */ 


	CURL *curl;
	CURLcode res;
	struct ResponseHeader r0_client_id;

	curl = curl_easy_init();
	handles[0] = curl;

	struct curl_slist *chunk = NULL;

	chunk = curl_slist_append(chunk, "User-Agent: NSPlayer/11.0.5721.5251");
    chunk = curl_slist_append(chunk, "X-Accept-Authentication: Negotiate, NTLM, Digest, Basic");
    chunk = curl_slist_append(chunk, "Pragma: version11-enabled=1");
    chunk = curl_slist_append(chunk, "Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=0:0,packet-num=4294967295,max-duration=0");
    chunk = curl_slist_append(chunk, "Pragma: packet-pair-experiment=1");
    chunk = curl_slist_append(chunk, "Pragma: pipeline-experiment=1");
    chunk = curl_slist_append(chunk, "Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm, com.microsoft.wm.startupprofilea");
    chunk = curl_slist_append(chunk, "Accept-Language: en-US, *;q=0.1");

	res = curl_easy_setopt(curl, CURLOPT_HTTPHEADER, chunk);
	curl_easy_setopt(curl, CURLOPT_URL, url);
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1l);
	/* cb_header will extract the client id */ 
	curl_easy_setopt(curl,  CURLOPT_HEADERFUNCTION, cb_header);
	curl_easy_setopt(curl,  CURLOPT_WRITEHEADER, (void*)&r0_client_id);
	/* send all data to this function  */ 
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, cb_data);
	res = curl_easy_perform(curl);

	if(CURLE_OK == res) {
		char *ct;
		long code;
		res = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &code);

		if((CURLE_OK == res) && code)
			printf("\nReceived HTTP Response Code: %lu\n", code);
		/* ask for the content-type */ 
		/* http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html */ 
		res = curl_easy_getinfo(curl, CURLINFO_CONTENT_TYPE, &ct);

		if((CURLE_OK == res) && ct)
			printf("Received Content-Type: %s\n", ct);
	} else {
		printf("ERROR:%s\n",curl_easy_strerror(res));

	}
	if(verbose) printf("client id is : %s \r\n", r0_client_id.client_id);
	char line_cid[100];
	char line_bw[128];
	sprintf(line_cid,"Pragma: client_id=%s",r0_client_id.client_id);
	if(speed == 1.0) 
	{ 
		sprintf(line_bw, "Pragma: LinkBW=2147483647, AccelBW=2147483647, AccelDuration=10000");
	} else {
		sprintf(line_bw,"Pragma: LinkBW=2147483647, AccelBW=2147483647, AccelDuration=10000, Speed=%f",speed);
	}
	chunk = curl_slist_append(chunk,"Pragma: xPlayStrm=1");
	chunk = curl_slist_append(chunk,line_cid);
	chunk = curl_slist_append(chunk,line_bw);
	chunk = curl_slist_append(chunk,"Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm");
	chunk = curl_slist_append(chunk,"Pragma: stream-switch-count=2");
	chunk = curl_slist_append(chunk,"Pragma: stream-switch-entry=ffff:1:0 ffff:2:0");
	chunk = curl_slist_append(chunk,"Accept-Language: en-us, *;q=0.1");
	chunk = curl_slist_append(chunk,"Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=4294967295:4294967295,packet-num=4294967295,max-duration=0");
	res = curl_easy_setopt(curl, CURLOPT_HTTPHEADER, chunk);
	curl_easy_setopt(curl, CURLOPT_URL, url);
	total_size = 0;//reset total size
    //Using multi handler, so that async r/w could be possible.
    //Why required?  CDS-IS WMT streamer will NOT disconnect TCP after sending out End-Of-Stream
	multi_handle = curl_multi_init();
	curl_multi_add_handle(multi_handle,curl);
	curl_multi_perform(multi_handle,&still_running);
	while(still_running) {
		struct timeval timeout;
		int rc; /* select() return code */ 

		fd_set fdread;
		fd_set fdwrite;
		fd_set fdexcep;
		int maxfd = -1;

		long curl_timeo = -1;

		FD_ZERO(&fdread);
		FD_ZERO(&fdwrite);
		FD_ZERO(&fdexcep);

		/* set a suitable timeout to play around with */ 
		timeout.tv_sec = 1;
		timeout.tv_usec = 0;

		curl_multi_timeout(multi_handle, &curl_timeo);
		if(curl_timeo >= 0) {
			timeout.tv_sec = curl_timeo / 1000;
			if(timeout.tv_sec > 1)
				timeout.tv_sec = 1;
			else
				timeout.tv_usec = (curl_timeo % 1000) * 1000;
		}

		/* get file descriptors from the transfers */ 
		curl_multi_fdset(multi_handle, &fdread, &fdwrite, &fdexcep, &maxfd);

		/* In a real-world program you OF COURSE check the return code of the
		   function calls.  On success, the value of maxfd is guaranteed to be
		   greater or equal than -1.  We call select(maxfd + 1, ...), specially in
		   case of (maxfd == -1), we call select(0, ...), which is basically equal
		   to sleep. */ 

		rc = select(maxfd+1, &fdread, &fdwrite, &fdexcep, &timeout);

		switch(rc) {
			case -1:
				/* select error */ 
				still_running = 0;
				printf("select() returns error, this is badness\n");
				break;
			case 0:
			default:
				if(end_of_stream == 0) {
					/* timeout or readable/writable sockets */ 
					curl_multi_perform(multi_handle, &still_running);
				} else { 
					//printf("swith default \r\n");
					still_running = 0;
				}

				break;
		}
	}
	//	res = curl_easy_perform(curl);
	//	if(CURLE_OK == res) {
	//		char *ct;
	//		/* ask for the content-type */ 
	//		/* http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html */ 
	//		res = curl_easy_getinfo(curl, CURLINFO_CONTENT_TYPE, &ct);
	//
	//		if((CURLE_OK == res) && ct)
	//			printf("We received Content-Type: %s\n", ct);
	//	}


	printf("Total data %lu Bytes Downloaded \n", total_size);

	/* See how the transfers went */ 
	while ((msg = curl_multi_info_read(multi_handle, &msgs_left))) {
		if (msg->msg == CURLMSG_DONE) {
			int idx, found = 0;

			/* Find out which handle this message is about */ 
			for (idx=0; idx<HANDLECOUNT; idx++) {
				found = (msg->easy_handle == handles[idx]);
				if(found)
					break;
			}

			switch (idx) {
				case HTTP_HANDLE:
					printf("HTTP transfer completed with status %d\n", msg->data.result);
					break;
				default:
					printf("Something Wrong %d\n", msg->data.result);
					break;
			}
		}
	}

	curl_multi_cleanup(multi_handle);

	/* always cleanup */ 
	curl_easy_cleanup(curl);
	return 0;
}
