<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>NeoCity 2.0 | Smart City Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/animejs@3.2.1/lib/anime.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    
    <style>
        :root {
            --primary: #6366f1;
            --primary-light: #818cf8;
            --primary-dark: #4f46e5;
            --secondary: #8b5cf6;
            --accent: #06b6d4;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #0f172a;
            --darker: #020617;
            --light: #f8fafc;
            --card-bg: rgba(30, 41, 59, 0.7);
            --glass: rgba(255, 255, 255, 0.05);
            --glow: 0 0 40px rgba(99, 102, 241, 0.3);
            --gradient-primary: linear-gradient(135deg, #6366f1, #8b5cf6);
            --gradient-success: linear-gradient(135deg, #10b981, #059669);
            --gradient-warning: linear-gradient(135deg, #f59e0b, #d97706);
            --gradient-danger: linear-gradient(135deg, #ef4444, #dc2626);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--darker);
            color: var(--light);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 80%, rgba(99, 102, 241, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(139, 92, 246, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(6, 182, 212, 0.1) 0%, transparent 50%);
            z-index: -1;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0%, 100% { transform: scale(1) rotate(0deg); }
            50% { transform: scale(1.1) rotate(1deg); }
        }

        .dashboard-container {
            max-width: 1600px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: var(--glow);
            animation: slideDown 0.8s ease;
            position: relative;
            overflow: hidden;
        }

        .header::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.05), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            100% { left: 100%; }
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .city-info {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .city-logo {
            width: 80px;
            height: 80px;
            background: var(--gradient-primary);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        .city-text h1 {
            font-size: 2.8rem;
            font-weight: 800;
            background: linear-gradient(to right, var(--primary-light), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .city-stats {
            display: flex;
            gap: 30px;
        }

        .stat-badge {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px 25px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            min-width: 150px;
            transition: all 0.3s ease;
        }

        .stat-badge:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary);
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 5px;
        }

        /* Navigation */
        .nav-container {
            position: relative;
            margin-bottom: 30px;
        }

        .nav-scroll {
            display: flex;
            gap: 15px;
            padding: 20px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            overflow-x: auto;
            scrollbar-width: none;
        }

        .nav-scroll::-webkit-scrollbar {
            display: none;
        }

        .nav-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 18px 30px;
            background: transparent;
            border: 2px solid transparent;
            color: #cbd5e1;
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            white-space: nowrap;
            font-weight: 600;
            font-size: 1rem;
            position: relative;
            overflow: hidden;
        }

        .nav-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.6s;
        }

        .nav-btn:hover::before {
            left: 100%;
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
            color: white;
        }

        .nav-btn.active {
            background: var(--gradient-primary);
            color: white;
            border-color: transparent;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.3);
            transform: translateY(-3px);
        }

        .nav-btn i {
            font-size: 1.2rem;
        }

        /* Main Content */
        .main-content {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 25px;
            margin-bottom: 40px;
        }

        .section {
            grid-column: span 12;
            display: none;
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section.active {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 25px;
        }

        /* Dashboard Cards */
        .dashboard-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
        }

        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--glow);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card-title i {
            color: var(--primary-light);
            font-size: 1.6rem;
        }

        /* Grid Layouts */
        .overview-grid {
            grid-column: span 12;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .metrics-grid {
            grid-column: span 12;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        /* KPI Cards */
        .kpi-card {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.8));
            padding: 25px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s ease;
        }

        .kpi-card:hover {
            border-color: var(--primary);
            transform: translateY(-5px);
        }

        .kpi-value {
            font-size: 3rem;
            font-weight: 900;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
        }

        .kpi-label {
            color: #94a3b8;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
        }

        .kpi-trend {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 15px;
            font-size: 0.9rem;
        }

        .trend-up { color: var(--success); }
        .trend-down { color: var(--danger); }
        .trend-stable { color: var(--warning); }

        /* Tables */
        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .data-table th {
            background: rgba(255, 255, 255, 0.05);
            padding: 20px;
            text-align: left;
            font-weight: 600;
            color: #cbd5e1;
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .data-table td {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            color: #e2e8f0;
        }

        .data-table tr {
            transition: background-color 0.3s ease;
        }

        .data-table tr:hover {
            background: rgba(255, 255, 255, 0.02);
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .status-high { background: rgba(239, 68, 68, 0.2); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); }
        .status-high .status-dot { background: var(--danger); box-shadow: 0 0 10px var(--danger); }
        
        .status-medium { background: rgba(245, 158, 11, 0.2); color: #fcd34d; border: 1px solid rgba(245, 158, 11, 0.3); }
        .status-medium .status-dot { background: var(--warning); box-shadow: 0 0 10px var(--warning); }
        
        .status-low { background: rgba(16, 185, 129, 0.2); color: #6ee7b7; border: 1px solid rgba(16, 185, 129, 0.3); }
        .status-low .status-dot { background: var(--success); box-shadow: 0 0 10px var(--success); }

        /* Role Badges */
        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 16px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .role-admin { background: rgba(139, 92, 246, 0.2); color: #a78bfa; border: 1px solid rgba(139, 92, 246, 0.3); }
        .role-security { background: rgba(239, 68, 68, 0.2); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); }
        .role-manager { background: rgba(6, 182, 212, 0.2); color: #67e8f9; border: 1px solid rgba(6, 182, 212, 0.3); }
        .role-env { background: rgba(16, 185, 129, 0.2); color: #6ee7b7; border: 1px solid rgba(16, 185, 129, 0.3); }

        /* Charts */
        .chart-container {
            position: relative;
            height: 300px;
            margin-top: 20px;
        }

        /* Progress Bars */
        .progress-bar {
            width: 100%;
            height: 8px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }

        .progress-fill {
            height: 100%;
            background: var(--gradient-primary);
            border-radius: 10px;
            transition: width 1s ease;
        }

        /* User Cards */
        .user-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .user-card {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.8));
            border-radius: 20px;
            padding: 25px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s ease;
        }

        .user-card:hover {
            border-color: var(--primary);
            transform: translateY(-5px);
        }

        .user-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .user-info h3 {
            font-size: 1.2rem;
            margin-bottom: 5px;
        }

        .user-role {
            font-size: 0.85rem;
            color: #94a3b8;
        }

        .user-details {
            display: grid;
            gap: 10px;
        }

        .user-detail {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .detail-label {
            color: #94a3b8;
            font-size: 0.85rem;
        }

        .detail-value {
            font-weight: 500;
            color: #e2e8f0;
        }

        /* Animations */
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .main-content {
                grid-template-columns: 1fr;
            }
            
            .section.active {
                grid-template-columns: 1fr;
            }
            
            .user-grid {
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .city-stats {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .stat-badge {
                min-width: 120px;
            }
            
            .nav-scroll {
                padding: 15px;
            }
            
            .nav-btn {
                padding: 15px 20px;
                font-size: 0.9rem;
            }
            
            .user-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .dashboard-container {
                padding: 10px;
            }
            
            .city-text h1 {
                font-size: 2rem;
            }
            
            .dashboard-card {
                padding: 20px;
            }
            
            .user-card {
                padding: 20px;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
            height: 10px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gradient-primary);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-dark);
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Header -->
        <header class="header">
            <div class="city-info">
                <div class="city-logo">
                    <i class="fas fa-city"></i>
                </div>
                <div class="city-text">
                    <h1><xsl:value-of select="/smartCity/@name"/></h1>
                    <p style="color: #94a3b8; margin-top: 5px;">
                        Smart City Dashboard • Real-time Monitoring System
                    </p>
                </div>
            </div>
            
            <div class="city-stats">
                <div class="stat-badge">
                    <div class="stat-value"><xsl:value-of select="/smartCity/@population"/></div>
                    <div class="stat-label">Population</div>
                </div>
                <div class="stat-badge">
                    <div class="stat-value"><xsl:value-of select="/smartCity/@version"/></div>
                    <div class="stat-label">Version</div>
                </div>
                <div class="stat-badge">
                    <div class="stat-value">
                        <xsl:value-of select="/smartCity/cityInfo/status"/>
                    </div>
                    <div class="stat-label">Status</div>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="nav-container">
            <div class="nav-scroll">
                <button class="nav-btn active" onclick="showSection('overview')">
                    <i class="fas fa-tachometer-alt"></i> Overview
                </button>
                <button class="nav-btn" onclick="showSection('traffic')">
                    <i class="fas fa-traffic-light"></i> Traffic
                </button>
                <button class="nav-btn" onclick="showSection('security')">
                    <i class="fas fa-shield-alt"></i> Security
                </button>
                <button class="nav-btn" onclick="showSection('environment')">
                    <i class="fas fa-leaf"></i> Environment
                </button>
                <button class="nav-btn" onclick="showSection('services')">
                    <i class="fas fa-hospital"></i> Services
                </button>
                <button class="nav-btn" onclick="showSection('iot')">
                    <i class="fas fa-microchip"></i> IoT
                </button>
                <button class="nav-btn" onclick="showSection('users')">
                    <i class="fas fa-users"></i> Users
                </button>
                <button class="nav-btn" onclick="showSection('analytics')">
                    <i class="fas fa-chart-line"></i> Analytics
                </button>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            
            <!-- Overview Section -->
            <section id="overview" class="section active">
                <div class="overview-grid">
                    <!-- City Health Score -->
                    <div class="dashboard-card" style="grid-column: span 4;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-heartbeat"></i> City Health Score
                            </h3>
                            <span class="status-badge status-high">
                                <span class="status-dot"></span>
                                <xsl:value-of select="/smartCity/analytics/cityHealth/@trend"/>
                            </span>
                        </div>
                        <div class="kpi-value">
                            <xsl:value-of select="/smartCity/analytics/cityHealth/@score"/>
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: {/smartCity/analytics/cityHealth/@score}%"></div>
                        </div>
                    </div>

                    <!-- Active Incidents -->
                    <div class="dashboard-card" style="grid-column: span 4;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-exclamation-triangle"></i> Active Incidents
                            </h3>
                        </div>
                        <div class="kpi-value pulse" style="color: var(--danger);">
                            <xsl:value-of select="count(/smartCity/security/incident[@status='Active' or @status='Investigating'])"/>
                        </div>
                        <div class="kpi-trend">
                            <i class="fas fa-arrow-up trend-down"></i>
                            <span>Requires Attention</span>
                        </div>
                    </div>

                    <!-- IoT Connectivity -->
                    <div class="dashboard-card" style="grid-column: span 4;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-wifi"></i> IoT Connectivity
                            </h3>
                        </div>
                        <xsl:variable name="iotPercent" select="round(/smartCity/iotDevices/@connected div /smartCity/iotDevices/@total * 100)"/>
                        <div class="kpi-value">
                            <xsl:value-of select="$iotPercent"/>%
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: {$iotPercent}%"></div>
                        </div>
                    </div>

                    <!-- Recent Incidents Table -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-history"></i> Recent Incidents
                            </h3>
                        </div>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Type</th>
                                    <th>Severity</th>
                                    <th>Zone</th>
                                    <th>Status</th>
                                    <th>Time</th>
                                    <th>Response</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="/smartCity/security/incident">
                                    <xsl:sort select="time" order="descending"/>
                                    <xsl:if test="position() &lt;= 5">
                                        <tr>
                                            <td><xsl:value-of select="@type"/></td>
                                            <td>
                                                <span class="status-badge status-{translate(@severity,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                                                    <span class="status-dot"></span>
                                                    <xsl:value-of select="@severity"/>
                                                </span>
                                            </td>
                                            <td><xsl:value-of select="zone"/></td>
                                            <td><xsl:value-of select="@status"/></td>
                                            <td><xsl:value-of select="substring(time, 12, 5)"/></td>
                                            <td>
                                                <xsl:choose>
                                                    <xsl:when test="responseTime">
                                                        <span style="color: var(--success);">
                                                            <xsl:value-of select="responseTime"/> min
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:otherwise>Pending</xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- Traffic Section -->
            <section id="traffic" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-traffic-light"></i> Traffic Overview
                        </h3>
                    </div>
                    <div class="metrics-grid">
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:variable name="avgSpeed" select="sum(/smartCity/infrastructure/traffic/intersection/avgSpeed) div count(/smartCity/infrastructure/traffic/intersection)"/>
                                <xsl:value-of select="format-number($avgSpeed, '0.0')"/>
                            </div>
                            <div class="kpi-label">Average Speed (km/h)</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="count(/smartCity/infrastructure/traffic/intersection)"/>
                            </div>
                            <div class="kpi-label">Active Intersections</div>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Intersection</th>
                                <th>Zone</th>
                                <th>Congestion</th>
                                <th>Avg Speed</th>
                                <th>Last Update</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="/smartCity/infrastructure/traffic/intersection">
                                <tr>
                                    <td><xsl:value-of select="@id"/></td>
                                    <td><xsl:value-of select="@zone"/></td>
                                    <td>
                                        <span class="status-badge status-{translate(congestionLevel,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                                            <span class="status-dot"></span>
                                            <xsl:value-of select="congestionLevel"/>
                                        </span>
                                    </td>
                                    <td><xsl:value-of select="avgSpeed"/> km/h</td>
                                    <td><xsl:value-of select="substring(lastUpdate, 12, 5)"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Security Section -->
            <section id="security" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-shield-alt"></i> Security Incidents
                        </h3>
                    </div>
                    <div class="chart-container">
                        <canvas id="securityChart"></canvas>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Type</th>
                                <th>Severity</th>
                                <th>Status</th>
                                <th>Zone</th>
                                <th>Location</th>
                                <th>Assigned</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="/smartCity/security/incident">
                                <tr>
                                    <td><xsl:value-of select="@id"/></td>
                                    <td><xsl:value-of select="@type"/></td>
                                    <td>
                                        <span class="status-badge status-{translate(@severity,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                                            <span class="status-dot"></span>
                                            <xsl:value-of select="@severity"/>
                                        </span>
                                    </td>
                                    <td><xsl:value-of select="@status"/></td>
                                    <td><xsl:value-of select="zone"/></td>
                                    <td><xsl:value-of select="location"/></td>
                                    <td><xsl:value-of select="assignedTo"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Environment Section -->
            <section id="environment" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-leaf"></i> Environment Monitoring
                        </h3>
                    </div>
                    <div class="metrics-grid">
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="/smartCity/environment/weather/current/temperature"/>°C
                            </div>
                            <div class="kpi-label">Temperature</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="/smartCity/environment/weather/current/humidity"/>
                            </div>
                            <div class="kpi-label">Humidity %</div>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Sensor</th>
                                <th>Zone</th>
                                <th>PM2.5</th>
                                <th>Quality</th>
                                <th>Health Advice</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="/smartCity/environment/airQuality/sensor">
                                <tr>
                                    <td><xsl:value-of select="@id"/></td>
                                    <td><xsl:value-of select="@zone"/></td>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="pm25 &gt; 50">
                                                <span style="color: var(--danger); font-weight: 600;">
                                                    <xsl:value-of select="pm25"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:when test="pm25 &gt; 25">
                                                <span style="color: var(--warning); font-weight: 600;">
                                                    <xsl:value-of select="pm25"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <span style="color: var(--success); font-weight: 600;">
                                                    <xsl:value-of select="pm25"/>
                                                </span>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </td>
                                    <td><xsl:value-of select="qualityIndex"/></td>
                                    <td><xsl:value-of select="healthAdvice"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Services Section -->
            <section id="services" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-hospital"></i> Public Services
                        </h3>
                    </div>
                    <div class="metrics-grid">
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="/smartCity/services/hospital/@bedsAvailable"/>
                            </div>
                            <div class="kpi-label">Hospital Beds Available</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="/smartCity/services/publicWiFi/@uptime"/>%
                            </div>
                            <div class="kpi-label">Public WiFi Uptime</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="/smartCity/environment/wasteManagement/recyclingRate"/>%
                            </div>
                            <div class="kpi-label">Recycling Rate</div>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Service</th>
                                <th>Zone</th>
                                <th>Status</th>
                                <th>Metrics</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Hospital H1</td>
                                <td><xsl:value-of select="/smartCity/services/hospital/@zone"/></td>
                                <td>
                                    <span class="status-badge status-low">
                                        <span class="status-dot"></span>
                                        Operational
                                    </span>
                                </td>
                                <td>
                                    <xsl:value-of select="/smartCity/services/hospital/@bedsAvailable"/> beds, 
                                    <xsl:value-of select="/smartCity/services/hospital/@waitingTime"/> min wait
                                </td>
                            </tr>
                            <tr>
                                <td>School S1</td>
                                <td><xsl:value-of select="/smartCity/services/school/@zone"/></td>
                                <td>
                                    <span class="status-badge status-low">
                                        <span class="status-dot"></span>
                                        <xsl:value-of select="/smartCity/services/school/@status"/>
                                    </span>
                                </td>
                                <td>
                                    <xsl:value-of select="/smartCity/services/school/studentsPresent"/> students present
                                </td>
                            </tr>
                            <tr>
                                <td>Public WiFi</td>
                                <td>Citywide</td>
                                <td>
                                    <span class="status-badge status-low">
                                        <span class="status-dot"></span>
                                        Active
                                    </span>
                                </td>
                                <td>
                                    <xsl:value-of select="/smartCity/services/publicWiFi/@accessPoints"/> access points, 
                                    <xsl:value-of select="/smartCity/services/publicWiFi/activeConnections"/> connections
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- IoT Section -->
            <section id="iot" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-microchip"></i> IoT Network Status
                        </h3>
                    </div>
                    <div class="metrics-grid">
                        <div class="kpi-card">
                            <div class="kpi-value"><xsl:value-of select="/smartCity/iotDevices/@total"/></div>
                            <div class="kpi-label">Total Devices</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value" style="color: var(--success);">
                                <xsl:value-of select="/smartCity/iotDevices/@connected"/>
                            </div>
                            <div class="kpi-label">Connected</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:variable name="iotRate" select="round(/smartCity/iotDevices/@connected div /smartCity/iotDevices/@total * 100)"/>
                                <xsl:value-of select="$iotRate"/>%
                            </div>
                            <div class="kpi-label">Connection Rate</div>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Device Type</th>
                                <th>Count</th>
                                <th>Percentage</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="/smartCity/iotDevices/device">
                                <tr>
                                    <td><xsl:value-of select="@type"/></td>
                                    <td><xsl:value-of select="@count"/></td>
                                    <td>
                                        <xsl:variable name="percent" select="format-number(@count div /smartCity/iotDevices/@total * 100, '0.0')"/>
                                        <xsl:value-of select="$percent"/>%
                                    </td>
                                    <td>
                                        <span class="status-badge status-low">
                                            <span class="status-dot"></span>
                                            Active
                                        </span>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Users Section -->
            <section id="users" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-users"></i> System Users
                        </h3>
                    </div>
                    
                    <!-- User Statistics -->
                    <div class="metrics-grid">
                        <div class="kpi-card">
                            <div class="kpi-value"><xsl:value-of select="count(/smartCity/users/user)"/></div>
                            <div class="kpi-label">Total Users</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="count(/smartCity/users/user[role='Admin' or role='CityManager'])"/>
                            </div>
                            <div class="kpi-label">Administrators</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-value">
                                <xsl:value-of select="count(/smartCity/users/user[role='SecurityOfficer' or role='EnvironmentalOfficer'])"/>
                            </div>
                            <div class="kpi-label">Operators</div>
                        </div>
                    </div>
                    
                    <!-- User Cards Grid -->
                    <div class="user-grid">
                        <xsl:for-each select="/smartCity/users/user">
                            <div class="user-card">
                                <div class="user-header">
                                    <div class="user-avatar">
                                        <xsl:value-of select="substring(name, 1, 1)"/>
                                    </div>
                                    <div class="user-info">
                                        <h3><xsl:value-of select="name"/></h3>
                                        <div class="user-role">
                                            <xsl:choose>
                                                <xsl:when test="@role='Admin'">
                                                    <span class="role-badge role-admin">
                                                        <i class="fas fa-crown"></i>
                                                        <xsl:value-of select="@role"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:when test="@role='SecurityOfficer'">
                                                    <span class="role-badge role-security">
                                                        <i class="fas fa-shield-alt"></i>
                                                        <xsl:value-of select="@role"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:when test="@role='CityManager'">
                                                    <span class="role-badge role-manager">
                                                        <i class="fas fa-cogs"></i>
                                                        <xsl:value-of select="@role"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:when test="@role='EnvironmentalOfficer'">
                                                    <span class="role-badge role-env">
                                                        <i class="fas fa-leaf"></i>
                                                        <xsl:value-of select="@role"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="role-badge role-admin">
                                                        <xsl:value-of select="@role"/>
                                                    </span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="user-details">
                                    <div class="user-detail">
                                        <span class="detail-label">ID:</span>
                                        <span class="detail-value"><xsl:value-of select="@id"/></span>
                                    </div>
                                    <div class="user-detail">
                                        <span class="detail-label">Email:</span>
                                        <span class="detail-value"><xsl:value-of select="email"/></span>
                                    </div>
                                    <div class="user-detail">
                                        <span class="detail-label">Department:</span>
                                        <span class="detail-value"><xsl:value-of select="@department"/></span>
                                    </div>
                                    <div class="user-detail">
                                        <span class="detail-label">Last Login:</span>
                                        <span class="detail-value">
                                            <xsl:value-of select="substring(lastLogin, 1, 10)"/>
                                            <xsl:text> at </xsl:text>
                                            <xsl:value-of select="substring(lastLogin, 12, 5)"/>
                                        </span>
                                    </div>
                                    <div class="user-detail">
                                        <span class="detail-label">Permissions:</span>
                                        <span class="detail-value" style="color: var(--primary-light);">
                                            <xsl:value-of select="permissions"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                    
                    <!-- User Summary Table -->
                    <table class="data-table" style="margin-top: 30px;">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Role</th>
                                <th>Department</th>
                                <th>Email</th>
                                <th>Last Activity</th>
                                <th>Permissions Level</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="/smartCity/users/user">
                                <tr>
                                    <td><xsl:value-of select="@id"/></td>
                                    <td><strong><xsl:value-of select="name"/></strong></td>
                                    <td>
                                        <xsl:choose>
                                            <xsl:when test="@role='Admin'">
                                                <span class="role-badge role-admin">
                                                    <xsl:value-of select="@role"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:when test="@role='SecurityOfficer'">
                                                <span class="role-badge role-security">
                                                    <xsl:value-of select="@role"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:when test="@role='CityManager'">
                                                <span class="role-badge role-manager">
                                                    <xsl:value-of select="@role"/>
                                                </span>
                                            </xsl:when>
                                            <xsl:when test="@role='EnvironmentalOfficer'">
                                                <span class="role-badge role-env">
                                                    <xsl:value-of select="@role"/>
                                                </span>
                                            </xsl:when>
                                        </xsl:choose>
                                    </td>
                                    <td><xsl:value-of select="@department"/></td>
                                    <td><xsl:value-of select="email"/></td>
                                    <td>
                                        <xsl:value-of select="substring(lastLogin, 12, 5)"/>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="substring(lastLogin, 1, 10)"/>
                                        <xsl:text>)</xsl:text>
                                    </td>
                                    <td>
                                        <span class="status-badge status-low">
                                            <xsl:choose>
                                                <xsl:when test="permissions='full'">
                                                    <span class="status-dot"></span>
                                                    Full Access
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="status-dot" style="background: var(--warning);"></span>
                                                    Limited Access
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Analytics Section -->
            <section id="analytics" class="section">
                <div class="overview-grid">
                    <xsl:for-each select="/smartCity/analytics/*">
                        <div class="dashboard-card" style="grid-column: span 3;">
                            <div class="card-header">
                                <h3 class="card-title">
                                    <xsl:choose>
                                        <xsl:when test="name() = 'cityHealth'"><i class="fas fa-heartbeat"></i></xsl:when>
                                        <xsl:when test="name() = 'safetyIndex'"><i class="fas fa-shield-alt"></i></xsl:when>
                                        <xsl:when test="name() = 'sustainabilityIndex'"><i class="fas fa-seedling"></i></xsl:when>
                                        <xsl:when test="name() = 'citizenSatisfaction'"><i class="fas fa-users"></i></xsl:when>
                                    </xsl:choose>
                                    <xsl:value-of select="
                                        translate(
                                            substring-before(
                                                concat(name(), 'Index'), 
                                                'Index'
                                            ), 
                                            'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 
                                            'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                                        )
                                    "/>
                                </h3>
                            </div>
                            <div class="kpi-value"><xsl:value-of select="@score"/></div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: {@score}%"></div>
                            </div>
                            <xsl:if test="@trend">
                                <div class="kpi-trend">
                                    <xsl:choose>
                                        <xsl:when test="@trend = 'Improving'">
                                            <i class="fas fa-arrow-up trend-up"></i>
                                            <span>Improving</span>
                                        </xsl:when>
                                        <xsl:when test="@trend = 'Declining'">
                                            <i class="fas fa-arrow-down trend-down"></i>
                                            <span>Declining</span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <i class="fas fa-minus trend-stable"></i>
                                            <span>Stable</span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </xsl:if>
                        </div>
                    </xsl:for-each>
                </div>
            </section>

        </main>
    </div>

    <script>
        // Navigation
        function showSection(sectionId) {
            // Remove active class from all buttons and sections
            document.querySelectorAll('.nav-btn').forEach(btn => {
                btn.classList.remove('active');
                anime({
                    targets: btn,
                    scale: 1,
                    duration: 300
                });
            });
            
            document.querySelectorAll('.section').forEach(section => {
                section.classList.remove('active');
                section.style.opacity = '0';
                section.style.transform = 'translateY(30px)';
            });

            // Add active class to clicked button
            const activeBtn = event.target;
            activeBtn.classList.add('active');
            anime({
                targets: activeBtn,
                scale: [1, 1.05, 1],
                duration: 600,
                easing: 'easeInOutQuad'
            });

            // Show selected section with animation
            const activeSection = document.getElementById(sectionId);
            setTimeout(() => {
                activeSection.classList.add('active');
                anime({
                    targets: activeSection,
                    opacity: 1,
                    translateY: 0,
                    duration: 800,
                    easing: 'easeOutCubic'
                });
            }, 100);

            // Animate cards in section
            setTimeout(() => {
                anime({
                    targets: activeSection.querySelectorAll('.dashboard-card, .kpi-card, .user-card'),
                    opacity: [0, 1],
                    translateY: [30, 0],
                    delay: anime.stagger(100),
                    duration: 600,
                    easing: 'easeOutCubic'
                });
            }, 300);
        }

        // Initialize animations
        document.addEventListener('DOMContentLoaded', function() {
            // Animate header elements
            anime({
                targets: '.city-logo',
                rotate: [0, 360],
                duration: 2000,
                easing: 'easeInOutSine',
                delay: 500
            });

            // Animate stat badges
            anime({
                targets: '.stat-badge',
                opacity: [0, 1],
                translateY: [20, 0],
                delay: anime.stagger(200),
                duration: 800,
                easing: 'easeOutCubic'
            });

            // Initialize charts
            initializeCharts();
        });

        function initializeCharts() {
            // Security Incident Chart
            const securityCtx = document.createElement('canvas');
            document.getElementById('securityChart').appendChild(securityCtx);
            
            new Chart(securityCtx, {
                type: 'bar',
                data: {
                    labels: ['High', 'Medium', 'Low'],
                    datasets: [{
                        label: 'Incidents by Severity',
                        data: [
                            <xsl:value-of select="count(/smartCity/security/incident[@severity='High'])"/>,
                            <xsl:value-of select="count(/smartCity/security/incident[@severity='Medium'])"/>,
                            <xsl:value-of select="count(/smartCity/security/incident[@severity='Low'])"/>
                        ],
                        backgroundColor: [
                            'rgba(239, 68, 68, 0.8)',
                            'rgba(245, 158, 11, 0.8)',
                            'rgba(16, 185, 129, 0.8)'
                        ],
                        borderColor: [
                            'rgb(239, 68, 68)',
                            'rgb(245, 158, 11)',
                            'rgb(16, 185, 129)'
                        ],
                        borderWidth: 2,
                        borderRadius: 10
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: {
                        duration: 2000,
                        easing: 'easeOutQuart'
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#cbd5e1',
                                font: {
                                    size: 14
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.05)'
                            },
                            ticks: {
                                color: '#94a3b8'
                            }
                        },
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.05)'
                            },
                            ticks: {
                                color: '#94a3b8'
                            }
                        }
                    }
                }
            });

            // Progress bar animations
            anime({
                targets: '.progress-fill',
                width: (el) => {
                    return el.style.width;
                },
                duration: 2000,
                delay: anime.stagger(100),
                easing: 'easeOutElastic(1, .8)'
            });
        }

        // Add hover effects to cards
        document.querySelectorAll('.dashboard-card, .kpi-card, .user-card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                anime({
                    targets: card,
                    scale: 1.02,
                    duration: 300,
                    easing: 'easeOutQuad'
                });
            });
            
            card.addEventListener('mouseleave', () => {
                anime({
                    targets: card,
                    scale: 1,
                    duration: 300,
                    easing: 'easeOutQuad'
                });
            });
        });

        // Real-time update simulation
        function simulateUpdates() {
            setInterval(() => {
                anime({
                    targets: '.pulse',
                    scale: [1, 1.05, 1],
                    duration: 1000,
                    easing: 'easeInOutQuad'
                });
            }, 3000);
        }

        // Start simulation
        simulateUpdates();
    </script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
