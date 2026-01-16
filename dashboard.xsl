<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="/">
    <html lang="en">
    <head>
      <meta charset="UTF-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>NeoCity 2.0 - Smart City Dashboard</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
      <style>
        /* Tous les styles CSS restent identiques */
        :root {
          --primary: #3b82f6;
          --secondary: #10b981;
          --danger: #ef4444;
          --warning: #f59e0b;
          --dark: #1e293b;
          --darker: #0f172a;
          --light: #f8fafc;
          --card-bg: rgba(30, 41, 59, 0.9);
          --shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
          --radius: 16px;
        }
        
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        
        body {
          font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
          background: linear-gradient(135deg, var(--darker) 0%, #1a1f3a 100%);
          color: var(--light);
          min-height: 100vh;
          padding: 20px;
        }
        
        .container {
          max-width: 1400px;
          margin: 0 auto;
        }
        
        .header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 30px;
          padding: 20px;
          background: var(--card-bg);
          border-radius: var(--radius);
          box-shadow: var(--shadow);
          backdrop-filter: blur(10px);
          border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .city-title {
          display: flex;
          align-items: center;
          gap: 15px;
        }
        
        .city-title h1 {
          font-size: 2.2rem;
          background: linear-gradient(90deg, #3b82f6, #8b5cf6);
          -webkit-background-clip: text;
          background-clip: text;
          color: transparent;
          font-weight: 700;
        }
        
        .city-info {
          display: flex;
          gap: 20px;
          font-size: 0.9rem;
          color: #94a3b8;
        }
        
        .dashboard-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
          gap: 25px;
          margin-bottom: 30px;
        }
        
        .card {
          background: var(--card-bg);
          border-radius: var(--radius);
          padding: 25px;
          box-shadow: var(--shadow);
          transition: transform 0.3s ease, box-shadow 0.3s ease;
          border: 1px solid rgba(255, 255, 255, 0.05);
          backdrop-filter: blur(10px);
        }
        
        .card:hover {
          transform: translateY(-5px);
          box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
        }
        
        .card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;
          padding-bottom: 15px;
          border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .card-title {
          display: flex;
          align-items: center;
          gap: 10px;
          font-size: 1.3rem;
          font-weight: 600;
        }
        
        .card-title i {
          font-size: 1.5rem;
        }
        
        .badge {
          padding: 4px 12px;
          border-radius: 20px;
          font-size: 0.8rem;
          font-weight: 600;
        }
        
        .badge-high { background: rgba(239, 68, 68, 0.2); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); }
        .badge-medium { background: rgba(245, 158, 11, 0.2); color: #fcd34d; border: 1px solid rgba(245, 158, 11, 0.3); }
        .badge-low { background: rgba(34, 197, 94, 0.2); color: #86efac; border: 1px solid rgba(34, 197, 94, 0.3); }
        .badge-critical { background: rgba(220, 38, 38, 0.2); color: #fecaca; border: 1px solid rgba(220, 38, 38, 0.3); }
        
        .incident-item {
          background: rgba(15, 23, 42, 0.5);
          border-radius: 12px;
          padding: 15px;
          margin-bottom: 15px;
          border-left: 4px solid;
        }
        
        .incident-high { border-left-color: #ef4444; }
        .incident-medium { border-left-color: #f59e0b; }
        .incident-low { border-left-color: #10b981; }
        
        .incident-header {
          display: flex;
          justify-content: space-between;
          margin-bottom: 8px;
        }
        
        .incident-type {
          font-weight: 600;
          color: #e2e8f0;
        }
        
        .incident-location {
          color: #94a3b8;
          font-size: 0.9rem;
          display: flex;
          align-items: center;
          gap: 5px;
          margin: 5px 0;
        }
        
        .incident-time {
          color: #64748b;
          font-size: 0.85rem;
        }
        
        .status-dot {
          display: inline-block;
          width: 10px;
          height: 10px;
          border-radius: 50%;
          margin-right: 8px;
        }
        
        .status-active { background: #ef4444; }
        .status-investigating { background: #f59e0b; }
        .status-resolved { background: #10b981; }
        
        .metrics-grid {
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          gap: 15px;
        }
        
        .metric-card {
          background: rgba(15, 23, 42, 0.5);
          border-radius: 12px;
          padding: 15px;
          text-align: center;
        }
        
        .metric-value {
          font-size: 2rem;
          font-weight: 700;
          margin: 10px 0;
        }
        
        .metric-label {
          color: #94a3b8;
          font-size: 0.9rem;
        }
        
        .aqi-indicator {
          height: 10px;
          border-radius: 5px;
          background: linear-gradient(90deg, #10b981, #f59e0b, #ef4444);
          margin: 15px 0;
          position: relative;
        }
        
        .aqi-marker {
          position: absolute;
          top: -5px;
          width: 20px;
          height: 20px;
          background: white;
          border-radius: 50%;
          transform: translateX(-50%);
          box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }
        
        .user-card {
          display: flex;
          align-items: center;
          gap: 15px;
          padding: 15px;
          background: rgba(15, 23, 42, 0.5);
          border-radius: 12px;
          margin-bottom: 15px;
        }
        
        .user-avatar {
          width: 50px;
          height: 50px;
          border-radius: 50%;
          background: linear-gradient(135deg, #3b82f6, #8b5cf6);
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 1.2rem;
          font-weight: 600;
        }
        
        .user-info h4 {
          margin-bottom: 5px;
          color: #e2e8f0;
        }
        
        .user-role {
          color: #94a3b8;
          font-size: 0.9rem;
        }
        
        .alert-banner {
          background: linear-gradient(90deg, rgba(239, 68, 68, 0.2), rgba(220, 38, 38, 0.1));
          border: 1px solid rgba(239, 68, 68, 0.3);
          border-radius: var(--radius);
          padding: 20px;
          margin: 25px 0;
          display: flex;
          align-items: center;
          gap: 15px;
          animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
          0%, 100% { opacity: 1; }
          50% { opacity: 0.8; }
        }
        
        .map-container {
          height: 300px;
          background: rgba(15, 23, 42, 0.5);
          border-radius: 12px;
          margin: 20px 0;
          position: relative;
          overflow: hidden;
        }
        
        .map-point {
          position: absolute;
          width: 20px;
          height: 20px;
          border-radius: 50%;
          transform: translate(-50%, -50%);
        }
        
        .point-high { background: #ef4444; box-shadow: 0 0 15px #ef4444; }
        .point-medium { background: #f59e0b; box-shadow: 0 0 15px #f59e0b; }
        .point-low { background: #10b981; box-shadow: 0 0 15px #10b981; }
        
        .charts-row {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
          gap: 25px;
          margin-top: 30px;
        }
        
        .chart-container {
          background: var(--card-bg);
          border-radius: var(--radius);
          padding: 25px;
          box-shadow: var(--shadow);
        }
        
        .chart-title {
          font-size: 1.2rem;
          font-weight: 600;
          margin-bottom: 20px;
          display: flex;
          align-items: center;
          gap: 10px;
        }
        
        .footer {
          text-align: center;
          margin-top: 40px;
          padding-top: 20px;
          border-top: 1px solid rgba(255, 255, 255, 0.1);
          color: #64748b;
          font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
          .dashboard-grid {
            grid-template-columns: 1fr;
          }
          
          .header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
          }
          
          .city-info {
            flex-wrap: wrap;
            justify-content: center;
          }
        }
      </style>
    </head>
    <body>
      <div class="container">
        <!-- Header -->
        <header class="header">
          <div class="city-title">
            <i class="fas fa-city" style="font-size: 2.5rem; color: #3b82f6;"></i>
            <div>
              <h1><xsl:value-of select="smartCity/@name"/> Dashboard</h1>
              <div class="city-info">
                <span><i class="fas fa-calendar"></i> <xsl:value-of select="smartCity/@date"/></span>
                <span><i class="fas fa-users"></i> Population: <xsl:value-of select="smartCity/@population"/></span>
                <span><i class="fas fa-signal"></i> IoT Devices: <xsl:value-of select="smartCity/iotDevices/@connected"/>/<xsl:value-of select="smartCity/iotDevices/@total"/></span>
              </div>
            </div>
          </div>
          <div class="city-health">
            <div class="metric-card">
              <div class="metric-label">City Health Score</div>
              <div class="metric-value" style="color: #10b981;"><xsl:value-of select="smartCity/analytics/cityHealth/@score"/></div>
              <div class="metric-label">Trend: <xsl:value-of select="smartCity/analytics/cityHealth/@trend"/></div>
            </div>
          </div>
        </header>
        
        <!-- Critical Alerts -->
        <xsl:if test="count(smartCity/security/incident[@severity='Critical']) > 0">
          <div class="alert-banner">
            <i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: #ef4444;"></i>
            <div>
              <h3 style="margin-bottom: 5px;">🚨 CRITICAL ALERT</h3>
              <p><xsl:value-of select="count(smartCity/security/incident[@severity='Critical'])"/> critical incidents require immediate attention!</p>
            </div>
          </div>
        </xsl:if>
        
        <!-- Main Dashboard Grid -->
        <div class="dashboard-grid">
          
          <!-- Security Incidents Card -->
          <div class="card">
            <div class="card-header">
              <div class="card-title">
                <i class="fas fa-shield-alt" style="color: #ef4444;"></i>
                <h2>Security Incidents</h2>
              </div>
              <div class="badge badge-high">
                <xsl:value-of select="count(smartCity/security/incident)"/> Active
              </div>
            </div>
            
            <xsl:for-each select="smartCity/security/incident">
              <xsl:sort select="@severity" order="descending"/>
              <xsl:sort select="time" order="descending"/>
              
              <div class="incident-item">
                <xsl:attribute name="class">
                  <xsl:text>incident-item incident-</xsl:text>
                  <xsl:choose>
                    <xsl:when test="@severity='High' or @severity='Critical'">high</xsl:when>
                    <xsl:when test="@severity='Medium'">medium</xsl:when>
                    <xsl:otherwise>low</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                
                <div class="incident-header">
                  <div class="incident-type">
                    <span>
                      <xsl:attribute name="class">
                        <xsl:text>status-dot status-</xsl:text>
                        <xsl:value-of select="translate(@status, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
                      </xsl:attribute>
                    </span>
                    <xsl:value-of select="@type"/>
                  </div>
                  <div>
                    <xsl:attribute name="class">
                      <xsl:text>badge badge-</xsl:text>
                      <xsl:value-of select="translate(@severity, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
                    </xsl:attribute>
                    <xsl:value-of select="@severity"/>
                  </div>
                </div>
                <div class="incident-location">
                  <i class="fas fa-map-marker-alt"></i>
                  <xsl:value-of select="location"/>, <xsl:value-of select="zone"/>
                </div>
                <div class="incident-time">
                  <i class="far fa-clock"></i>
                  <xsl:value-of select="substring(time, 12, 8)"/>
                  <span style="margin-left: 15px;">Status: <xsl:value-of select="@status"/></span>
                  <xsl:if test="assignedTo">
                    <span style="margin-left: 15px;">
                      <i class="fas fa-user-shield"></i> Assigned
                    </span>
                  </xsl:if>
                </div>
              </div>
            </xsl:for-each>
          </div>
          
          <!-- Environmental Monitoring Card -->
          <div class="card">
            <div class="card-header">
              <div class="card-title">
                <i class="fas fa-leaf" style="color: #10b981;"></i>
                <h2>Environmental Quality</h2>
              </div>
              <xsl:variable name="badAir" select="smartCity/environment/airQuality/sensor[qualityIndex='Bad' or qualityIndex='Hazardous']"/>
              <xsl:choose>
                <xsl:when test="$badAir">
                  <div class="badge badge-high">Poor Air Quality</div>
                </xsl:when>
                <xsl:otherwise>
                  <div class="badge badge-low">Good Conditions</div>
                </xsl:otherwise>
              </xsl:choose>
            </div>
            
            <xsl:for-each select="smartCity/environment/airQuality/sensor">
              <div style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid rgba(255,255,255,0.1);">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                  <div>
                    <h4 style="color: #e2e8f0;"><xsl:value-of select="@zone"/> Zone</h4>
                    <div style="color: #94a3b8; font-size: 0.9rem;">
                      AQI: <xsl:value-of select="qualityIndex"/>
                    </div>
                  </div>
                  <div>
                    <xsl:attribute name="class">
                      <xsl:text>badge badge-</xsl:text>
                      <xsl:value-of select="translate(qualityIndex, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', 'abcdefghijklmnopqrstuvwxyz-')"/>
                    </xsl:attribute>
                    <xsl:value-of select="qualityIndex"/>
                  </div>
                </div>
                
                <div class="aqi-indicator">
                  <xsl:variable name="aqiPosition">
                    <xsl:choose>
                      <xsl:when test="qualityIndex='Excellent'">10</xsl:when>
                      <xsl:when test="qualityIndex='Good'">30</xsl:when>
                      <xsl:when test="qualityIndex='Moderate'">50</xsl:when>
                      <xsl:when test="qualityIndex='Poor'">70</xsl:when>
                      <xsl:when test="qualityIndex='Bad'">85</xsl:when>
                      <xsl:otherwise>95</xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <div class="aqi-marker">
                    <xsl:attribute name="style">
                      <xsl:text>left: </xsl:text>
                      <xsl:value-of select="$aqiPosition"/>
                      <xsl:text>%;</xsl:text>
                    </xsl:attribute>
                  </div>
                </div>
                
                <div style="color: #64748b; font-size: 0.85rem; margin-top: 10px;">
                  <i class="fas fa-info-circle"></i>
                  <xsl:value-of select="healthAdvice"/>
                </div>
              </div>
            </xsl:for-each>
            
            <!-- Weather Info -->
            <div style="margin-top: 20px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1);">
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-cloud-sun" style="color: #3b82f6;"></i> Weather
              </h4>
              <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                  <div style="font-size: 2rem; font-weight: 700;">
                    <xsl:value-of select="smartCity/environment/weather/current/temperature"/>°C
                  </div>
                  <div style="color: #94a3b8;">
                    <xsl:value-of select="smartCity/environment/weather/current/condition"/>
                  </div>
                </div>
                <div style="text-align: right;">
                  <div style="color: #94a3b8;">Humidity: <xsl:value-of select="smartCity/environment/weather/current/humidity"/>%</div>
                  <div style="color: #94a3b8;">Wind: <xsl:value-of select="smartCity/environment/weather/current/windSpeed"/> km/h</div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Infrastructure Status Card -->
          <div class="card">
            <div class="card-header">
              <div class="card-title">
                <i class="fas fa-road" style="color: #3b82f6;"></i>
                <h2>Infrastructure</h2>
              </div>
              <xsl:variable name="trafficIssues" select="smartCity/infrastructure/traffic/intersection[congestionLevel='High' or congestionLevel='Severe']"/>
              <xsl:choose>
                <xsl:when test="$trafficIssues">
                  <div class="badge badge-medium">Traffic Issues</div>
                </xsl:when>
                <xsl:otherwise>
                  <div class="badge badge-low">Normal</div>
                </xsl:otherwise>
              </xsl:choose>
            </div>
            
            <!-- Traffic Status -->
            <div style="margin-bottom: 25px;">
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-traffic-light"></i> Traffic Conditions
              </h4>
              <xsl:for-each select="smartCity/infrastructure/traffic/intersection">
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px; background: rgba(15,23,42,0.5); border-radius: 8px; margin-bottom: 10px;">
                  <div>
                    <div style="font-weight: 600; color: #e2e8f0;"><xsl:value-of select="@zone"/></div>
                    <div style="color: #94a3b8; font-size: 0.9rem;">Intersection <xsl:value-of select="@id"/></div>
                  </div>
                  <div>
                    <div style="text-align: right;">
                      <xsl:choose>
                        <xsl:when test="congestionLevel='Low'">
                          <span style="color: #10b981; font-weight: 600;">Light Traffic</span>
                        </xsl:when>
                        <xsl:when test="congestionLevel='Medium'">
                          <span style="color: #f59e0b; font-weight: 600;">Moderate</span>
                        </xsl:when>
                        <xsl:when test="congestionLevel='High'">
                          <span style="color: #ef4444; font-weight: 600;">Heavy</span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span style="color: #dc2626; font-weight: 600;">Severe</span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                    <div style="color: #64748b; font-size: 0.85rem;">
                      Avg: <xsl:value-of select="avgSpeed"/> km/h
                    </div>
                  </div>
                </div>
              </xsl:for-each>
            </div>
            
            <!-- Public Transport -->
            <div style="margin-bottom: 25px;">
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-subway"></i> Public Transport
              </h4>
              <xsl:for-each select="smartCity/infrastructure/publicTransport/*">
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px; background: rgba(15,23,42,0.5); border-radius: 8px; margin-bottom: 10px;">
                  <div>
                    <div style="font-weight: 600; color: #e2e8f0;">
                      <xsl:value-of select="local-name()"/> <xsl:value-of select="@id"/>
                    </div>
                    <div style="color: #94a3b8; font-size: 0.9rem;">
                      <xsl:value-of select="passengerCount"/> passengers
                    </div>
                  </div>
                  <div>
                    <xsl:choose>
                      <xsl:when test="@status='Delayed'">
                        <div style="color: #f59e0b; font-weight: 600;">Delayed</div>
                        <div style="color: #64748b; font-size: 0.85rem;">
                          +<xsl:value-of select="delayMinutes"/> min
                        </div>
                      </xsl:when>
                      <xsl:when test="@status='Suspended'">
                        <div style="color: #ef4444; font-weight: 600;">Suspended</div>
                      </xsl:when>
                      <xsl:otherwise>
                        <div style="color: #10b981; font-weight: 600;">On Time</div>
                      </xsl:otherwise>
                    </xsl:choose>
                  </div>
                </div>
              </xsl:for-each>
            </div>
            
            <!-- Energy Grid -->
            <div>
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-bolt" style="color: #f59e0b;"></i> Energy Grid
              </h4>
              <div style="text-align: center;">
                <div style="font-size: 2.5rem; font-weight: 700; margin: 10px 0;">
                  <xsl:value-of select="smartCity/infrastructure/energy/smartGrid/@loadPercentage"/>%
                </div>
                <div style="color: #94a3b8;">Current Load</div>
                <div style="margin-top: 15px; padding: 10px; background: rgba(15,23,42,0.5); border-radius: 8px;">
                  Status: 
                  <span>
                    <xsl:attribute name="style">
                      <xsl:text>font-weight: 600; color: </xsl:text>
                      <xsl:choose>
                        <xsl:when test="smartCity/infrastructure/energy/smartGrid/@status='Stable'">#10b981</xsl:when>
                        <xsl:when test="smartCity/infrastructure/energy/smartGrid/@status='Under Stress'">#f59e0b</xsl:when>
                        <xsl:otherwise>#ef4444</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>;</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="smartCity/infrastructure/energy/smartGrid/@status"/>
                  </span>
                </div>
              </div>
            </div>
          </div>
          
          <!-- System Users Card -->
          <div class="card">
            <div class="card-header">
              <div class="card-title">
                <i class="fas fa-users-cog" style="color: #8b5cf6;"></i>
                <h2>System Users</h2>
              </div>
              <div class="badge">
                <xsl:value-of select="count(smartCity/users/user)"/> Active
              </div>
            </div>
            
            <xsl:for-each select="smartCity/users/user">
              <div class="user-card">
                <div class="user-avatar">
                  <xsl:value-of select="substring(name, 1, 1)"/>
                </div>
                <div class="user-info">
                  <h4><xsl:value-of select="name"/></h4>
                  <div class="user-role">
                    <xsl:value-of select="@role"/>
                    <xsl:if test="@department">
                      <span style="margin-left: 10px; color: #64748b;">
                        (<xsl:value-of select="@department"/>)
                      </span>
                    </xsl:if>
                  </div>
                  <div style="color: #64748b; font-size: 0.85rem; margin-top: 5px;">
                    Last login: <xsl:value-of select="substring(lastLogin, 12, 5)"/>
                  </div>
                </div>
              </div>
            </xsl:for-each>
          </div>
          
          <!-- Services Status Card -->
          <div class="card">
            <div class="card-header">
              <div class="card-title">
                <i class="fas fa-hospital" style="color: #10b981;"></i>
                <h2>Public Services</h2>
              </div>
            </div>
            
            <!-- Healthcare -->
            <div style="margin-bottom: 25px;">
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-ambulance"></i> Healthcare
              </h4>
              <xsl:for-each select="smartCity/services/hospital">
                <div style="padding: 15px; background: rgba(15,23,42,0.5); border-radius: 12px; margin-bottom: 15px;">
                  <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <div style="font-weight: 600; color: #e2e8f0;">Hospital <xsl:value-of select="@id"/></div>
                    <div>
                      <span style="color: #10b981; font-weight: 600;">
                        <xsl:value-of select="@bedsAvailable"/> beds
                      </span>
                    </div>
                  </div>
                  <div style="color: #94a3b8; font-size: 0.9rem;">
                    <xsl:value-of select="@zone"/> Zone
                    <span style="margin-left: 15px;">Wait time: <xsl:value-of select="@waitingTime"/> min</span>
                  </div>
                </div>
              </xsl:for-each>
            </div>
            
            <!-- Education -->
            <div style="margin-bottom: 25px;">
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-school"></i> Education
              </h4>
              <xsl:for-each select="smartCity/services/school">
                <div style="padding: 15px; background: rgba(15,23,42,0.5); border-radius: 12px;">
                  <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <div style="font-weight: 600; color: #e2e8f0;">School <xsl:value-of select="@id"/></div>
                    <div>
                      <xsl:choose>
                        <xsl:when test="@status='Open'">
                          <span style="color: #10b981; font-weight: 600;">Open</span>
                        </xsl:when>
                        <xsl:when test="@status='Closed'">
                          <span style="color: #ef4444; font-weight: 600;">Closed</span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span style="color: #f59e0b; font-weight: 600;">Remote</span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                  </div>
                  <div style="color: #94a3b8; font-size: 0.9rem;">
                    <xsl:value-of select="studentsPresent"/> students present
                    <span style="margin-left: 15px;">Air quality: <xsl:value-of select="airQualityInClassroom"/></span>
                  </div>
                </div>
              </xsl:for-each>
            </div>
            
            <!-- Public WiFi -->
            <div>
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-wifi"></i> Public WiFi
              </h4>
              <div style="text-align: center; padding: 20px; background: rgba(15,23,42,0.5); border-radius: 12px;">
                <div style="font-size: 2.5rem; font-weight: 700; margin: 10px 0;">
                  <xsl:value-of select="smartCity/services/publicWiFi/@uptime"/>%
                </div>
                <div style="color: #94a3b8;">Network Uptime</div>
                <div style="margin-top: 15px; color: #64748b;">
                  <xsl:value-of select="smartCity/services/publicWiFi/activeConnections"/> active connections
                </div>
              </div>
            </div>
          </div>
          
          <!-- City Analytics Card -->
          <div class="card">
            <div class="card-header">
              <div class="card-title">
                <i class="fas fa-chart-line" style="color: #8b5cf6;"></i>
                <h2>City Analytics</h2>
              </div>
            </div>
            
            <div class="metrics-grid">
              <div class="metric-card">
                <div class="metric-label">Safety Index</div>
                <div class="metric-value">
                  <xsl:value-of select="smartCity/analytics/safetyIndex/@score"/>
                </div>
                <div class="metric-label">out of 100</div>
              </div>
              
              <div class="metric-card">
                <div class="metric-label">Sustainability</div>
                <div class="metric-value" style="color: #10b981;">
                  <xsl:value-of select="smartCity/analytics/sustainabilityIndex/@score"/>
                </div>
                <div class="metric-label">out of 100</div>
              </div>
              
              <div class="metric-card">
                <div class="metric-label">Citizen Satisfaction</div>
                <div class="metric-value" style="color: #3b82f6;">
                  <xsl:value-of select="smartCity/analytics/citizenSatisfaction/@score"/>
                </div>
                <div class="metric-label">out of 100</div>
              </div>
            </div>
            
            <!-- IoT Devices Summary -->
            <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1);">
              <h4 style="color: #e2e8f0; margin-bottom: 15px;">
                <i class="fas fa-microchip"></i> IoT Network
              </h4>
              <div style="display: flex; flex-wrap: wrap; gap: 15px;">
                <xsl:for-each select="smartCity/iotDevices/device">
                  <div style="padding: 10px 15px; background: rgba(15,23,42,0.7); border-radius: 10px; flex: 1; min-width: 120px;">
                    <div style="font-weight: 600; color: #e2e8f0;">
                      <xsl:value-of select="@count"/>
                    </div>
                    <div style="color: #94a3b8; font-size: 0.85rem;">
                      <xsl:value-of select="@type"/>
                    </div>
                  </div>
                </xsl:for-each>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Footer -->
        <footer class="footer">
          <div>
            <p>NeoCity 2.0 Smart City Management System | Version <xsl:value-of select="smartCity/@version"/></p>
            <p>Data last updated: <xsl:value-of select="smartCity/@date"/> | Emergency: <xsl:value-of select="smartCity/cityInfo/emergencyNumber"/></p>
            <p style="margin-top: 10px; color: #475569;">
              <i class="fas fa-lock"></i> Secure Connection | 
              <i class="fas fa-sync-alt"></i> Real-time Updates |
              <i class="fas fa-robot"></i> AI-Powered Analytics
            </p>
          </div>
        </footer>
      </div>
      
      <!-- JavaScript for interactivity -->
      <script>
        // Auto-refresh dashboard every 30 seconds
        setTimeout(function() {
          location.reload();
        }, 30000);
        
        // Incident click handler
        document.querySelectorAll('.incident-item').forEach(item => {
          item.addEventListener('click', function() {
            alert('Incident details would open in a modal or new view.');
          });
        });
      </script>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>