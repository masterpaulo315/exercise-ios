configuration=
{
	daemon=false,
	instancesCount=-1,
	pathSeparator="/",
	logAppenders=
	{
		{
			name="console appender",
			type="console",
			level=6
		},
	},
	applications=
	{
		rootDirectory="./",
		{
			appDir="./",
			name="evostreamms",
			description="EVOSTREAM MEDIA SERVER",
			protocol="dynamiclinklibrary",
			default=true,
			pushPullPersistenceFile="pushPullSetup.xml",
			authPersistenceFile="auth.xml",
			connectionsLimitPersistenceFile="connlimits.xml",
			bandwidthLimitPersistenceFile="bandwidthlimits.xml",
			ingestPointsPersistenceFile="ingestpoints.xml",
			streamsExpireTimer=10,
			rtcpDetectionInterval=15,
			hasStreamAliases=false,
			hasIngestPoints=false,
			validateHandshake=false,
			aliases={"er", "live", "vod"},
			maxRtmpOutBuffer=512*1024,
			mediaStorage = {
				recordedStreamsStorage="media",
				{
					description="Default media storage",
					mediaFolder="media",
				},

				--[[
				-- the following is an example and contains all
				-- available properties along with their default
				-- values(except paths, of course)
				sample={
					description="Storage example",
					mediaFolder="/some/media/folder",
					metaFolder="/fast/discardable/separate/folder",
					enableStats=false,
					clientSideBuffer=15,
					keyframeSeek=true,
					seekGranularity=0.1,
					externalSeekGenerator=false,
				}
				]]--
			},
			acceptors=
			{
				-- CLI aceptors
				{
					ip="0.0.0.0",
					port=2112,
					protocol="inboundJsonCli",
					useLengthPadding=true
				},
				{
					ip="0.0.0.0",
					port=7788,
					protocol="inboundHttpJsonCli"
				},
                {
                    path="com.evostream.evostreamms.cli",
                    protocol="inboundUdsJsonCli"
                },
				-- RTMP and clustering
				{
					ip="0.0.0.0",
					port=1955,
					protocol="inboundRtmp",
				},
				{
					ip="127.0.0.1",
					port=1956,
					protocol="inboundRtmp",
					clustering=true
				},
			
				-- LiveFLV ingest
				{
					ip="0.0.0.0",
					port=6665,
					protocol="inboundLiveFlv",
					waitForMetadata=true,
				},

				-- HTTP
				{
					ip="0.0.0.0",
					port=8585,
					protocol="inboundHttp",
				},

                -- TCP RAW
                {
                    ip="127.0.0.1",
                    port=10005,
                    protocol="tcpRawMedia"
                },
                -- UDS RAW
                {
                    path="com.evostream.evostreamms.uds",
                    protocol="udsRawMedia"
                },
				-- WebSockets FMP4 Fetch
				{
					ip="0.0.0.0",
					port=8415,
					protocol="inboundWSFMP4"
				},
			},
			--[[
			autoHLS=
			{
				targetFolder= "media",
			},
			autoHDS=
			{
				targetFolder= "media",
			},
			]]--
			--[[
			authentication=
			{
				rtmp=
				{
					type="adobe",
					encoderAgents=
					{
						"FMLE/3.0 (compatible; FMSc/1.0)",
						"Wirecast/FM 1.0 (compatible; FMSc/1.0)",
						"EvoStream Media Server (www.evostream.com)"
					},
					usersFile="users.lua"
				},
				rtsp=
				{
					usersFile="users.lua",
					--authenticatePlay=false,
				}
			},
			]]--
			--[[
			eventLogger=
			{
				-- the following customData node will be apended to all outgoing
				-- events generated by this logger.
				customData=123,
				sinks=
				{
					{
						-- the following customData node will be apended to all
						-- events generated by this sink. It overwrides the
						-- customData node defined on the upper level. It can
						-- also be a complex structure like this
						customData =
						{
							some="string",
							number=123.456,
							array={1, 2.345, "Hello world", true, nil}
						},
						type="file",
						filename="logs\\events.txt",
						--format="text",
						--format="xml",
						format="json",
					},
					{
						type="RPC",
						url="http://localhost/evowebservices/evowebservices.php",
						serializerType="JSON",
						-- serializerType="XML"
						-- serializerType="XMLRPC"
						enabledEvents=
						{
							"inStreamCreated",
							"outStreamCreated",
							"streamCreated",
							"inStreamCodecsUpdated",
							"outStreamCodecsUpdated",
							"streamCodecsUpdated",
							"inStreamClosed",
							"outStreamClosed",
							"streamClosed",
							"cliRequest",
							"cliResponse",
							"applicationStart",
							"applicationStop",
							"carrierCreated",
							"carrierClosed",
							"serverStarted",
							"serverStopping",
							"protocolRegisteredToApp",
							"protocolUnregisteredFromApp",
							"processStarted",
							"processStopped",
							"timerCreated",
							"timerTriggered",
							"timerClosed",							
							"hlsChunkCreated",
							"hlsChunkClosed",
							"hlsChunkError",
							"hlsChildPlaylistUpdated",
							"hlsMasterPlaylistUpdated",
							"hdsChunkCreated",
							"hdsChunkClosed",
							"hdsChunkError",
							"hdsChildPlaylistUpdated",
							"hdsMasterPlaylistUpdated"
						},
					},
				},
			},
			
			transcoder = {
				scriptPath="emsTranscoder.bat",
				srcUriPrefix="rtsp://localhost:5544/",
				dstUriPrefix="-f flv tcp://localhost:6666/"
			},
			mp4BinPath="./mp4writer_arm64",
            ]]--
			--WebRTC
			webrtc = {
				sslKey="server.key",
				sslCert="server.cert",
			},
			--[[
			drm={
				type="verimatrix",
				requestTimer=1,
				reserveKeys=10,
				reserveIds=10,
				-- urlPrefix="http://server1.evostream1.com:12684/CAB/keyfile"
				urlPrefix="http://vcas3multicas1.verimatrix.com:12684/CAB/keyfile"
			},
			]]--
		},
	}
}