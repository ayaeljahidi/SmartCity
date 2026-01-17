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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/animejs@3.2.1/lib/anime.min.js"></script>
    
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
            --gradient-dark: linear-gradient(135deg, #0f172a, #1e293b);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
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
            animation: gradientShift 20s ease infinite alternate;
        }

        @keyframes gradientShift {
            0% { transform: scale(1) rotate(0deg); }
            50% { transform: scale(1.05) rotate(0.5deg); }
            100% { transform: scale(1) rotate(-0.5deg); }
        }

        /* Dashboard Container */
        .dashboard-container {
            max-width: 1800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            margin-bottom: 25px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            box-shadow: var(--glow);
            position: relative;
            overflow: hidden;
            animation: slideDown 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.03), transparent);
            animation: shimmer 4s infinite linear;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        @keyframes slideDown {
            from { 
                opacity: 0; 
                transform: translateY(-30px) scale(0.95); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0) scale(1); 
            }
        }

        .city-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .city-logo {
            width: 70px;
            height: 70px;
            background: var(--gradient-primary);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            animation: float 8s ease-in-out infinite;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        @keyframes float {
            0%, 100% { 
                transform: translateY(0) rotate(0deg); 
            }
            50% { 
                transform: translateY(-15px) rotate(5deg); 
            }
        }

        .city-text h1 {
            font-size: 2.4rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary-light), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .city-subtitle {
            color: #94a3b8;
            font-size: 0.9rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .city-subtitle::before {
            content: '';
            width: 6px;
            height: 6px;
            background: var(--success);
            border-radius: 50%;
            display: inline-block;
            animation: pulseDot 2s infinite;
        }

        @keyframes pulseDot {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        .city-stats {
            display: flex;
            gap: 20px;
        }

        .stat-badge {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.04);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.06);
            min-width: 120px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .stat-badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .stat-badge:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.06);
            border-color: rgba(255, 255, 255, 0.1);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .stat-badge:hover::before {
            transform: scaleX(1);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
        }

        .stat-label {
            font-size: 0.8rem;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 8px;
            font-weight: 600;
        }

        /* Navigation */
        .nav-container {
            position: relative;
            margin-bottom: 25px;
        }

        .nav-scroll {
            display: flex;
            gap: 10px;
            padding: 15px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.06);
            overflow-x: auto;
            scrollbar-width: none;
        }

        .nav-scroll::-webkit-scrollbar {
            display: none;
        }

        .nav-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px 22px;
            background: transparent;
            border: 1px solid transparent;
            color: #94a3b8;
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            white-space: nowrap;
            font-weight: 600;
            font-size: 0.9rem;
            position: relative;
            overflow: hidden;
        }

        .nav-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), rgba(139, 92, 246, 0.1));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .nav-btn:hover {
            color: white;
            border-color: rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.03);
            transform: translateY(-2px);
        }

        .nav-btn:hover::before {
            opacity: 1;
        }

        .nav-btn.active {
            background: var(--gradient-primary);
            color: white;
            border-color: transparent;
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
            transform: translateY(-2px);
        }

        .nav-btn i {
            font-size: 1.1rem;
        }

        /* Main Content */
        .main-content {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        .section {
            grid-column: span 12;
            display: none;
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from { 
                opacity: 0; 
                transform: translateY(20px) scale(0.98); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0) scale(1); 
            }
        }

        .section.active {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 20px;
        }

        /* Dashboard Cards */
        .dashboard-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 25px;
            border: 1px solid rgba(255, 255, 255, 0.06);
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
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--glow);
            border-color: rgba(99, 102, 241, 0.2);
        }

        .dashboard-card:hover::before {
            transform: scaleX(1);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: white;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-title i {
            color: var(--primary-light);
            font-size: 1.3rem;
        }

        /* Grid Layouts */
        .overview-grid {
            grid-column: span 12;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .metrics-grid {
            grid-column: span 12;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        /* KPI Cards */
        .kpi-card {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
            padding: 20px;
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.1), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .kpi-card:hover {
            border-color: rgba(99, 102, 241, 0.3);
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .kpi-card:hover::before {
            opacity: 1;
        }

        .kpi-value {
            font-size: 2.5rem;
            font-weight: 900;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 5px;
        }

        .kpi-label {
            color: #94a3b8;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }

        .kpi-trend {
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 10px;
            font-size: 0.85rem;
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
            background: rgba(255, 255, 255, 0.04);
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: #cbd5e1;
            border-bottom: 2px solid rgba(255, 255, 255, 0.08);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .data-table td {
            padding: 16px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.03);
            color: #e2e8f0;
            font-size: 0.9rem;
        }

        .data-table tr {
            transition: all 0.2s ease;
        }

        .data-table tr:hover {
            background: rgba(255, 255, 255, 0.02);
            transform: translateX(4px);
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
            transition: all 0.2s ease;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
        }

        .status-high { 
            background: rgba(239, 68, 68, 0.15); 
            color: #fca5a5; 
            border: 1px solid rgba(239, 68, 68, 0.2); 
        }
        .status-high .status-dot { 
            background: var(--danger); 
            box-shadow: 0 0 8px var(--danger); 
        }
        
        .status-medium { 
            background: rgba(245, 158, 11, 0.15); 
            color: #fcd34d; 
            border: 1px solid rgba(245, 158, 11, 0.2); 
        }
        .status-medium .status-dot { 
            background: var(--warning); 
            box-shadow: 0 0 8px var(--warning); 
        }
        
        .status-low { 
            background: rgba(16, 185, 129, 0.15); 
            color: #6ee7b7; 
            border: 1px solid rgba(16, 185, 129, 0.2); 
        }
        .status-low .status-dot { 
            background: var(--success); 
            box-shadow: 0 0 8px var(--success); 
        }

        /* Role Badges */
        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .role-admin { 
            background: rgba(139, 92, 246, 0.15); 
            color: #a78bfa; 
            border: 1px solid rgba(139, 92, 246, 0.2); 
        }
        .role-security { 
            background: rgba(239, 68, 68, 0.15); 
            color: #fca5a5; 
            border: 1px solid rgba(239, 68, 68, 0.2); 
        }
        .role-manager { 
            background: rgba(6, 182, 212, 0.15); 
            color: #67e8f9; 
            border: 1px solid rgba(6, 182, 212, 0.2); 
        }
        .role-env { 
            background: rgba(16, 185, 129, 0.15); 
            color: #6ee7b7; 
            border: 1px solid rgba(16, 185, 129, 0.2); 
        }

        /* Charts */
        .chart-container {
            position: relative;
            height: 280px;
            margin-top: 20px;
            border-radius: 12px;
            overflow: hidden;
        }

        /* Progress Bars */
        .progress-bar {
            width: 100%;
            height: 6px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
            margin: 8px 0;
        }

        .progress-fill {
            height: 100%;
            background: var(--gradient-primary);
            border-radius: 10px;
            transition: width 1s ease;
            position: relative;
            overflow: hidden;
        }

        .progress-fill::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmerProgress 2s infinite;
        }

        @keyframes shimmerProgress {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        /* User Cards */
        .user-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .user-card {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.8), rgba(15, 23, 42, 0.9));
            border-radius: 16px;
            padding: 22px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .user-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--gradient-primary);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .user-card:hover {
            border-color: rgba(99, 102, 241, 0.3);
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .user-card:hover::before {
            opacity: 1;
        }

        .user-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 18px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            font-weight: bold;
            color: white;
            flex-shrink: 0;
        }

        .user-info h3 {
            font-size: 1.1rem;
            margin-bottom: 4px;
            color: white;
        }

        .user-role {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .user-details {
            display: grid;
            gap: 8px;
        }

        .user-detail {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
        }

        .detail-label {
            color: #94a3b8;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .detail-value {
            font-weight: 500;
            color: #e2e8f0;
            font-size: 0.85rem;
        }

        /* Quick Stats */
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }

        .quick-stat {
            background: rgba(255, 255, 255, 0.03);
            border-radius: 14px;
            padding: 18px;
            border: 1px solid rgba(255, 255, 255, 0.04);
            transition: all 0.2s ease;
        }

        .quick-stat:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.08);
        }

        .quick-stat-label {
            color: #94a3b8;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .quick-stat-value {
            font-size: 1.8rem;
            font-weight: 800;
            color: white;
        }

        /* Animations */
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
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
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
                padding: 20px;
            }
            
            .city-stats {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .stat-badge {
                min-width: 110px;
            }
            
            .nav-scroll {
                padding: 12px;
            }
            
            .nav-btn {
                padding: 12px 16px;
                font-size: 0.85rem;
            }
            
            .city-text h1 {
                font-size: 2rem;
            }
            
            .dashboard-card {
                padding: 20px;
            }
        }

        @media (max-width: 480px) {
            .dashboard-container {
                padding: 15px;
            }
            
            .city-text h1 {
                font-size: 1.7rem;
            }
            
            .stat-value {
                font-size: 1.7rem;
            }
            
            .kpi-value {
                font-size: 2rem;
            }
            
            .user-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.03);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gradient-primary);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-dark);
        }

        /* Loading States */
        .loading {
            position: relative;
            overflow: hidden;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.05), transparent);
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            100% { left: 100%; }
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
                    <div class="city-subtitle">
                        Smart City Dashboard • Real-time Monitoring System
                    </div>
                </div>
            </div>
            
            <div class="city-stats">
                <div class="stat-badge">
                    <div class="stat-value"><xsl:value-of select="format-number(/smartCity/@population, '#,##0')"/></div>
                    <div class="stat-label">Population</div>
                </div>
                <div class="stat-badge">
                    <div class="stat-value">v<xsl:value-of select="/smartCity/@version"/></div>
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
                <!-- Quick Stats Row -->
                <div class="quick-stats" style="grid-column: span 12;">
                    <div class="quick-stat">
                        <div class="quick-stat-label">Active Incidents</div>
                        <div class="quick-stat-value pulse" style="color: var(--danger);">
                            <xsl:value-of select="count(/smartCity/security/incident[@status='Active' or @status='Investigating'])"/>
                        </div>
                    </div>
                    <div class="quick-stat">
                        <div class="quick-stat-label">IoT Connected</div>
                        <div class="quick-stat-value" style="color: var(--success);">
                            <xsl:value-of select="format-number(/smartCity/iotDevices/@connected, '#,##0')"/>
                        </div>
                    </div>
                    <div class="quick-stat">
                        <div class="quick-stat-label">Air Quality</div>
                        <div class="quick-stat-value">
                            <xsl:value-of select="count(/smartCity/environment/airQuality/sensor[qualityIndex='Good' or qualityIndex='Excellent'])"/>/<xsl:value-of select="count(/smartCity/environment/airQuality/sensor)"/>
                        </div>
                    </div>
                    <div class="quick-stat">
                        <div class="quick-stat-label">Response Time</div>
                        <div class="quick-stat-value">
                            <xsl:variable name="avgResponse" select="sum(/smartCity/security/incident/responseTime) div count(/smartCity/security/incident[responseTime])"/>
                            <xsl:choose>
                                <xsl:when test="$avgResponse &gt; 0">
                                    <xsl:value-of select="format-number($avgResponse, '0.0')"/>min
                                </xsl:when>
                                <xsl:otherwise>N/A</xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </div>
                </div>

                <!-- Main Cards -->
                <div class="overview-grid">
                    <!-- City Health Score -->
                    <div class="dashboard-card">
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
                        <div class="kpi-trend">
                            <i class="fas fa-arrow-up trend-down"></i>
                            <span>Requires Attention</span>
                        </div>
                    </div>

                    <!-- IoT Connectivity -->
                    <div class="dashboard-card">
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
                        <div class="kpi-trend">
                            <i class="fas fa-arrow-up trend-up"></i>
                            <span>Excellent Connection</span>
                        </div>
                    </div>

                    <!-- Environment Status -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-temperature-high"></i> Environment Status
                            </h3>
                        </div>
                        <div class="kpi-value">
                            <xsl:value-of select="/smartCity/environment/weather/current/temperature"/>°C
                        </div>
                        <div class="kpi-label">
                            Temperature • Humidity: <xsl:value-of select="/smartCity/environment/weather/current/humidity"/>%
                        </div>
                        <div class="kpi-trend">
                            <i class="fas fa-wind"></i>
                            <span>Wind: <xsl:value-of select="/smartCity/environment/weather/current/windSpeed"/> km/h</span>
                        </div>
                    </div>

                    <!-- Recent Incidents Table -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-history"></i> Recent Incidents
                            </h3>
                            <button class="status-badge status-medium" onclick="showSection('security')" style="cursor: pointer;">
                                <span class="status-dot"></span>
                                View All
                            </button>
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
                                                        <span style="color: var(--success); font-weight: 600;">
                                                            <xsl:value-of select="responseTime"/> min
                                                        </span>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <span style="color: var(--warning);">Pending</span>
                                                    </xsl:otherwise>
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
                <div class="overview-grid">
                    <!-- Traffic Overview -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-traffic-light"></i> Traffic Management
                            </h3>
                            <div class="quick-stats" style="display: flex; gap: 15px; margin: 0;">
                                <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                    <div class="quick-stat-label">Total Intersections</div>
                                    <div class="quick-stat-value" style="font-size: 1.5rem;">
                                        <xsl:value-of select="count(/smartCity/infrastructure/traffic/intersection)"/>
                                    </div>
                                </div>
                                <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                    <div class="quick-stat-label">Average Speed</div>
                                    <div class="quick-stat-value" style="font-size: 1.5rem;">
                                        <xsl:value-of select="format-number(sum(/smartCity/infrastructure/traffic/intersection/avgSpeed) div count(/smartCity/infrastructure/traffic/intersection), '0')"/> km/h
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Intersections Table -->
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Intersection ID</th>
                                    <th>Zone</th>
                                    <th>Congestion Level</th>
                                    <th>Average Speed</th>
                                    <th>Last Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="/smartCity/infrastructure/traffic/intersection">
                                    <tr>
                                        <td><xsl:value-of select="@id"/></td>
                                        <td><xsl:value-of select="@zone"/></td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="congestionLevel='High' or congestionLevel='Severe'">
                                                    <span class="status-badge status-high">
                                                        <span class="status-dot"></span>
                                                        <xsl:value-of select="congestionLevel"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:when test="congestionLevel='Medium'">
                                                    <span class="status-badge status-medium">
                                                        <span class="status-dot"></span>
                                                        <xsl:value-of select="congestionLevel"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="status-badge status-low">
                                                        <span class="status-dot"></span>
                                                        <xsl:value-of select="congestionLevel"/>
                                                    </span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                        <td><xsl:value-of select="avgSpeed"/> km/h</td>
                                        <td><xsl:value-of select="substring(lastUpdate, 12, 5)"/></td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </div>

                    <!-- Public Transport -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-bus"></i> Public Transport
                            </h3>
                        </div>
                        <div class="metrics-grid">
                            <xsl:for-each select="/smartCity/infrastructure/publicTransport/*">
                                <div class="kpi-card">
                                    <div class="kpi-value">
                                        <xsl:value-of select="@id"/>
                                    </div>
                                    <div class="kpi-label">
                                        <xsl:value-of select="local-name()"/>
                                    </div>
                                    <div class="kpi-trend">
                                        <xsl:choose>
                                            <xsl:when test="@status='Delayed'">
                                                <i class="fas fa-exclamation-triangle" style="color: var(--warning);"></i>
                                                <span>Delayed: <xsl:value-of select="delayMinutes"/> min</span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <i class="fas fa-check-circle" style="color: var(--success);"></i>
                                                <span>On Time: <xsl:value-of select="delayMinutes"/> min</span>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div style="margin-top: 10px; font-size: 0.85rem;">
                                        Passengers: <xsl:value-of select="passengerCount"/>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>

                    <!-- Energy Management -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-bolt"></i> Energy Status
                            </h3>
                        </div>
                        <div class="kpi-value" style="font-size: 2rem;">
                            <xsl:value-of select="/smartCity/infrastructure/energy/smartGrid/@loadPercentage"/>%
                        </div>
                        <div class="kpi-label">
                            Smart Grid Load
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: {/smartCity/infrastructure/energy/smartGrid/@loadPercentage}%"></div>
                        </div>
                        <div style="margin-top: 20px;">
                            <h4>Power Plants</h4>
                            <xsl:for-each select="/smartCity/infrastructure/energy/powerPlant">
                                <div style="margin-top: 10px; padding: 10px; background: rgba(255,255,255,0.03); border-radius: 8px;">
                                    <strong><xsl:value-of select="@id"/></strong>
                                    (<xsl:value-of select="@type"/>)
                                    <br/>
                                    Output: <xsl:value-of select="@outputMW"/> MW
                                    <br/>
                                    Efficiency: <xsl:value-of select="efficiency"/>%
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Security Section -->
            <section id="security" class="section">
                <div class="overview-grid">
                    <!-- Security Overview -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-shield-alt"></i> Security Incidents
                            </h3>
                            <div class="quick-stats" style="display: flex; gap: 15px; margin: 0;">
                                <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                    <div class="quick-stat-label">Total Incidents</div>
                                    <div class="quick-stat-value" style="font-size: 1.5rem;">
                                        <xsl:value-of select="count(/smartCity/security/incident)"/>
                                    </div>
                                </div>
                                <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                    <div class="quick-stat-label">Active</div>
                                    <div class="quick-stat-value" style="font-size: 1.5rem; color: var(--danger);">
                                        <xsl:value-of select="count(/smartCity/security/incident[@status='Active' or @status='Investigating'])"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Incidents Table -->
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Incident ID</th>
                                    <th>Type</th>
                                    <th>Severity</th>
                                    <th>Zone</th>
                                    <th>Status</th>
                                    <th>Time</th>
                                    <th>Assigned To</th>
                                    <th>Response Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="/smartCity/security/incident">
                                    <xsl:sort select="time" order="descending"/>
                                    <tr>
                                        <td><xsl:value-of select="@id"/></td>
                                        <td><xsl:value-of select="@type"/></td>
                                        <td>
                                            <span class="status-badge status-{translate(@severity,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                                                <span class="status-dot"></span>
                                                <xsl:value-of select="@severity"/>
                                            </span>
                                        </td>
                                        <td><xsl:value-of select="zone"/></td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="@status='Active'">
                                                    <span class="status-badge status-high">
                                                        <span class="status-dot"></span>
                                                        <xsl:value-of select="@status"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:when test="@status='Investigating'">
                                                    <span class="status-badge status-medium">
                                                        <span class="status-dot"></span>
                                                        <xsl:value-of select="@status"/>
                                                    </span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="status-badge status-low">
                                                        <span class="status-dot"></span>
                                                        <xsl:value-of select="@status"/>
                                                    </span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                        <td><xsl:value-of select="substring(time, 12, 5)"/></td>
                                        <td><xsl:value-of select="assignedTo"/></td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="responseTime">
                                                    <span style="color: var(--success); font-weight: 600;">
                                                        <xsl:value-of select="responseTime"/> min
                                                    </span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span style="color: var(--warning);">Pending</span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </div>

                    <!-- Surveillance Cameras -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-video"></i> Surveillance System
                            </h3>
                        </div>
                        <div class="metrics-grid">
                            <xsl:for-each select="/smartCity/security/surveillance/camera">
                                <div class="kpi-card">
                                    <div class="kpi-value">
                                        <xsl:value-of select="@id"/>
                                    </div>
                                    <div class="kpi-label">
                                        Zone: <xsl:value-of select="@zone"/>
                                    </div>
                                    <div class="kpi-trend">
                                        <xsl:choose>
                                            <xsl:when test="@status='Active'">
                                                <i class="fas fa-check-circle" style="color: var(--success);"></i>
                                                <span>Active</span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <i class="fas fa-tools" style="color: var(--warning);"></i>
                                                <span>Maintenance</span>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div style="margin-top: 10px; font-size: 0.85rem;">
                                        Last Motion: <xsl:value-of select="substring(lastMotion, 12, 5)"/>
                                        <br/>
                                        AI Detection: <xsl:value-of select="aiDetection"/>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Environment Section -->
            <section id="environment" class="section">
                <div class="overview-grid">
                    <!-- Air Quality -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-wind"></i> Air Quality Monitoring
                            </h3>
                        </div>
                        <div class="metrics-grid">
                            <xsl:for-each select="/smartCity/environment/airQuality/sensor">
                                <div class="kpi-card">
                                    <div class="kpi-value">
                                        <xsl:value-of select="qualityIndex"/>
                                    </div>
                                    <div class="kpi-label">
                                        Zone: <xsl:value-of select="@zone"/>
                                    </div>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: {pm25 div 100 * 100}%"></div>
                                    </div>
                                    <div style="margin-top: 10px; font-size: 0.8rem;">
                                        PM2.5: <xsl:value-of select="pm25"/>
                                        <br/>
                                        PM10: <xsl:value-of select="pm10"/>
                                        <br/>
                                        Last Update: <xsl:value-of select="substring(timestamp, 12, 5)"/>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>

                    <!-- Weather -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-sun"></i> Current Weather
                            </h3>
                        </div>
                        <div class="kpi-value">
                            <xsl:value-of select="/smartCity/environment/weather/current/temperature"/>°C
                        </div>
                        <div class="kpi-label">
                            <xsl:value-of select="/smartCity/environment/weather/current/condition"/>
                        </div>
                        <div class="kpi-trend">
                            <i class="fas fa-tint"></i>
                            <span>Humidity: <xsl:value-of select="/smartCity/environment/weather/current/humidity"/>%</span>
                        </div>
                        <div class="kpi-trend">
                            <i class="fas fa-wind"></i>
                            <span>Wind: <xsl:value-of select="/smartCity/environment/weather/current/windSpeed"/> km/h</span>
                        </div>
                        
                        <!-- Forecast -->
                        <div style="margin-top: 20px; padding-top: 15px; border-top: 1px solid rgba(255,255,255,0.1);">
                            <h4>Tomorrow's Forecast</h4>
                            <div style="display: flex; justify-content: space-between; margin-top: 10px;">
                                <div>
                                    <div style="font-size: 1.2rem; font-weight: bold;">
                                        <xsl:value-of select="/smartCity/environment/weather/forecast[@period='Tomorrow']/high"/>°C
                                    </div>
                                    <div style="font-size: 0.8rem;">High</div>
                                </div>
                                <div>
                                    <div style="font-size: 1.2rem; font-weight: bold;">
                                        <xsl:value-of select="/smartCity/environment/weather/forecast[@period='Tomorrow']/low"/>°C
                                    </div>
                                    <div style="font-size: 0.8rem;">Low</div>
                                </div>
                                <div>
                                    <div style="font-size: 1.2rem;">
                                        <xsl:value-of select="/smartCity/environment/weather/forecast[@period='Tomorrow']/condition"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Waste Management -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-trash-alt"></i> Waste Management
                            </h3>
                        </div>
                        <div class="kpi-value">
                            <xsl:value-of select="/smartCity/environment/wasteManagement/recyclingRate"/>%
                        </div>
                        <div class="kpi-label">
                            Recycling Rate
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: {/smartCity/environment/wasteManagement/recyclingRate}%"></div>
                        </div>
                        
                        <!-- Smart Bins -->
                        <div style="margin-top: 20px;">
                            <h4>Smart Bins</h4>
                            <xsl:for-each select="/smartCity/environment/wasteManagement/smartBin">
                                <div style="margin-top: 10px; padding: 10px; background: rgba(255,255,255,0.03); border-radius: 8px;">
                                    <strong><xsl:value-of select="@id"/></strong> - <xsl:value-of select="@zone"/>
                                    <br/>
                                    Fill Level: <xsl:value-of select="@fillLevel"/>%
                                    <br/>
                                    Next Collection: <xsl:value-of select="substring(nextCollection, 12, 5)"/>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Services Section -->
            <section id="services" class="section">
                <div class="overview-grid">
                    <!-- Hospital -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-hospital"></i> Hospital Status
                            </h3>
                        </div>
                        <xsl:variable name="totalBeds" select="sum(/smartCity/services/hospital/@bedsAvailable)"/>
                        <xsl:variable name="totalHospitals" select="count(/smartCity/services/hospital)"/>
                        <div class="kpi-value">
                            <xsl:value-of select="$totalBeds"/>
                        </div>
                        <div class="kpi-label">
                            Total Beds Available (<xsl:value-of select="$totalHospitals"/> hospitals)
                        </div>
                        <div class="kpi-trend">
                            <i class="fas fa-clock"></i>
                            <span>Avg Waiting: <xsl:value-of select="format-number(sum(/smartCity/services/hospital/@waitingTime) div $totalHospitals, '0')"/> min</span>
                        </div>
                        <div style="margin-top: 15px;">
                            <h4>All Hospitals</h4>
                            <xsl:for-each select="/smartCity/services/hospital">
                                <div style="margin-top: 10px; padding: 10px; background: rgba(255,255,255,0.03); border-radius: 8px;">
                                    <strong><xsl:value-of select="@id"/></strong> - <xsl:value-of select="@zone"/>
                                    <br/>
                                    Beds: <xsl:value-of select="@bedsAvailable"/> • Wait: <xsl:value-of select="@waitingTime"/> min
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>

                    <!-- School -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-school"></i> School Status
                            </h3>
                        </div>
                        <xsl:variable name="totalStudents" select="sum(/smartCity/services/school/studentsPresent)"/>
                        <xsl:variable name="totalSchools" select="count(/smartCity/services/school)"/>
                        <div class="kpi-value">
                            <xsl:value-of select="$totalStudents"/>
                        </div>
                        <div class="kpi-label">
                            Students Present (<xsl:value-of select="$totalSchools"/> schools)
                        </div>
                        <div class="kpi-trend">
                            <xsl:variable name="openSchools" select="count(/smartCity/services/school[@status='Open'])"/>
                            <i class="fas fa-check-circle" style="color: var(--success);"></i>
                            <span><xsl:value-of select="$openSchools"/>/<xsl:value-of select="$totalSchools"/> Open</span>
                        </div>
                        <div style="margin-top: 15px;">
                            <h4>All Schools</h4>
                            <xsl:for-each select="/smartCity/services/school">
                                <div style="margin-top: 10px; padding: 10px; background: rgba(255,255,255,0.03); border-radius: 8px;">
                                    <strong><xsl:value-of select="@id"/></strong> - <xsl:value-of select="@zone"/>
                                    <br/>
                                    Status: <xsl:value-of select="@status"/> • Students: <xsl:value-of select="studentsPresent"/>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>

                    <!-- Public WiFi -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-wifi"></i> Public WiFi
                            </h3>
                        </div>
                        <xsl:for-each select="/smartCity/services/publicWiFi">
                            <div class="kpi-value">
                                <xsl:value-of select="@uptime"/>%
                            </div>
                            <div class="kpi-label">
                                Uptime
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: {@uptime}%"></div>
                            </div>
                            <div style="margin-top: 20px;">
                                <div style="display: flex; justify-content: space-between;">
                                    <div>
                                        <div style="font-size: 1.5rem; font-weight: bold;">
                                            <xsl:value-of select="@accessPoints"/>
                                        </div>
                                        <div style="font-size: 0.8rem;">Access Points</div>
                                    </div>
                                    <div>
                                        <div style="font-size: 1.5rem; font-weight: bold;">
                                            <xsl:value-of select="activeConnections"/>
                                        </div>
                                        <div style="font-size: 0.8rem;">Active Connections</div>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </section>

            <!-- IoT Section -->
            <section id="iot" class="section">
                <div class="overview-grid">
                    <!-- IoT Overview -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-microchip"></i> IoT Network Status
                            </h3>
                            <div class="quick-stats" style="display: flex; gap: 15px; margin: 0;">
                                <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                    <div class="quick-stat-label">Total Devices</div>
                                    <div class="quick-stat-value" style="font-size: 1.5rem;">
                                        <xsl:value-of select="format-number(/smartCity/iotDevices/@total, '#,##0')"/>
                                    </div>
                                </div>
                                <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                    <div class="quick-stat-label">Connected</div>
                                    <div class="quick-stat-value" style="font-size: 1.5rem; color: var(--success);">
                                        <xsl:value-of select="format-number(/smartCity/iotDevices/@connected, '#,##0')"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- IoT Devices Breakdown -->
                        <div class="metrics-grid" style="margin-top: 20px;">
                            <xsl:for-each select="/smartCity/iotDevices/device">
                                <div class="kpi-card">
                                    <div class="kpi-value">
                                        <xsl:value-of select="format-number(@count, '#,##0')"/>
                                    </div>
                                    <div class="kpi-label">
                                        <xsl:value-of select="@type"/>
                                    </div>
                                    <xsl:variable name="percent" select="round(@count div /smartCity/iotDevices/@total * 100)"/>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: {$percent}%"></div>
                                    </div>
                                    <div class="kpi-trend">
                                        <span><xsl:value-of select="$percent"/>% of total</span>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Users Section -->
            <section id="users" class="section">
                <div class="dashboard-card" style="grid-column: span 12;">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-users"></i> System Users
                        </h3>
                        <div class="quick-stats" style="display: flex; gap: 15px; margin: 0;">
                            <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                <div class="quick-stat-label">Total Users</div>
                                <div class="quick-stat-value" style="font-size: 1.5rem;">
                                    <xsl:value-of select="count(/smartCity/users/user)"/>
                                </div>
                            </div>
                            <div class="quick-stat" style="padding: 10px 15px; min-width: auto;">
                                <div class="quick-stat-label">Active Now</div>
                                <div class="quick-stat-value" style="font-size: 1.5rem; color: var(--success);">
                                    <xsl:value-of select="count(/smartCity/users/user[@status='Active'])"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- User Cards Grid -->
                    <div class="user-grid">
                        <xsl:for-each select="/smartCity/users/user">
                            <xsl:sort select="name"/>
                            <div class="user-card">
                                <div class="user-header">
                                    <div class="user-avatar">
                                        <xsl:value-of select="substring(name, 1, 1)"/>
                                    </div>
                                    <div class="user-info">
                                        <h3><xsl:value-of select="name"/></h3>
                                        <div class="user-role">
                                            <span class="role-badge role-admin">
                                                <i class="fas fa-user"></i>
                                                <xsl:value-of select="@department"/>
                                            </span>
                                            <span class="status-badge status-{translate(@status,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                                                <span class="status-dot"></span>
                                                <xsl:value-of select="@status"/>
                                            </span>
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
                                            <xsl:value-of select="substring(lastLogin, 12, 5)"/>
                                            <xsl:text> today</xsl:text>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                    
                    <!-- User Summary Table -->
                    <div style="margin-top: 30px;">
                        <h3 class="card-title" style="margin-bottom: 15px;">
                            <i class="fas fa-table"></i> User Details Table
                        </h3>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>Name</th>
                                    <th>Status</th>
                                    <th>Department</th>
                                    <th>Email</th>
                                    <th>Last Activity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="/smartCity/users/user">
                                    <xsl:sort select="name"/>
                                    <tr>
                                        <td><xsl:value-of select="@id"/></td>
                                        <td><strong><xsl:value-of select="name"/></strong></td>
                                        <td>
                                            <span class="status-badge status-{translate(@status,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                                                <span class="status-dot"></span>
                                                <xsl:value-of select="@status"/>
                                            </span>
                                        </td>
                                        <td><xsl:value-of select="@department"/></td>
                                        <td><xsl:value-of select="email"/></td>
                                        <td>
                                            <xsl:value-of select="substring(lastLogin, 12, 5)"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- Analytics Section -->
            <section id="analytics" class="section">
                <div class="overview-grid">
                    <!-- City Analytics Overview -->
                    <div class="dashboard-card" style="grid-column: span 12;">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-chart-line"></i> City Analytics Dashboard
                            </h3>
                        </div>
                        
                        <!-- Analytics KPIs -->
                        <div class="metrics-grid">
                            <div class="kpi-card">
                                <div class="kpi-value">
                                    <xsl:value-of select="/smartCity/analytics/cityHealth/@score"/>
                                </div>
                                <div class="kpi-label">
                                    City Health Score
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: {/smartCity/analytics/cityHealth/@score}%"></div>
                                </div>
                                <div class="kpi-trend">
                                    <xsl:choose>
                                        <xsl:when test="/smartCity/analytics/cityHealth/@trend='Improving'">
                                            <i class="fas fa-arrow-up trend-up"></i>
                                            <span>Trend: <xsl:value-of select="/smartCity/analytics/cityHealth/@trend"/></span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <i class="fas fa-arrow-down trend-down"></i>
                                            <span>Trend: <xsl:value-of select="/smartCity/analytics/cityHealth/@trend"/></span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </div>
                            
                            <div class="kpi-card">
                                <div class="kpi-value">
                                    <xsl:value-of select="/smartCity/analytics/safetyIndex/@score"/>
                                </div>
                                <div class="kpi-label">
                                    Safety Index
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: {/smartCity/analytics/safetyIndex/@score}%"></div>
                                </div>
                            </div>
                            
                            <div class="kpi-card">
                                <div class="kpi-value">
                                    <xsl:value-of select="/smartCity/analytics/sustainabilityIndex/@score"/>
                                </div>
                                <div class="kpi-label">
                                    Sustainability Index
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: {/smartCity/analytics/sustainabilityIndex/@score}%"></div>
                                </div>
                            </div>
                            
                            <div class="kpi-card">
                                <div class="kpi-value">
                                    <xsl:value-of select="/smartCity/analytics/citizenSatisfaction/@score"/>
                                </div>
                                <div class="kpi-label">
                                    Citizen Satisfaction
                                </div>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: {/smartCity/analytics/citizenSatisfaction/@score}%"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- City Information -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-info-circle"></i> City Information
                            </h3>
                        </div>
                        <div class="user-details">
                            <xsl:for-each select="/smartCity/cityInfo/*">
                                <div class="user-detail">
                                    <span class="detail-label">
                                        <xsl:choose>
                                            <xsl:when test="name()='mayor'">Mayor</xsl:when>
                                            <xsl:when test="name()='emergencyNumber'">Emergency</xsl:when>
                                            <xsl:when test="name()='website'">Website</xsl:when>
                                            <xsl:when test="name()='timezone'">Timezone</xsl:when>
                                            <xsl:when test="name()='status'">Status</xsl:when>
                                        </xsl:choose>
                                    </span>
                                    <span class="detail-value">
                                        <xsl:choose>
                                            <xsl:when test="name()='website'">
                                                <a href="{.}" style="color: var(--primary-light); text-decoration: none;">
                                                    <xsl:value-of select="."/>
                                                </a>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </span>
                                </div>
                            </xsl:for-each>
                            <div class="user-detail">
                                <span class="detail-label">Population</span>
                                <span class="detail-value"><xsl:value-of select="format-number(/smartCity/@population, '#,##0')"/></span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">Version</span>
                                <span class="detail-value"><xsl:value-of select="/smartCity/@version"/></span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">Date</span>
                                <span class="detail-value"><xsl:value-of select="/smartCity/@date"/></span>
                            </div>
                        </div>
                    </div>

                    <!-- City Summary -->
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-chart-pie"></i> City Summary
                            </h3>
                        </div>
                        <div class="user-details">
                            <div class="user-detail">
                                <span class="detail-label">Total Incidents Today</span>
                                <span class="detail-value"><xsl:value-of select="count(/smartCity/security/incident)"/></span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">IoT Connectivity</span>
                                <xsl:variable name="iotPercent" select="round(/smartCity/iotDevices/@connected div /smartCity/iotDevices/@total * 100)"/>
                                <span class="detail-value"><xsl:value-of select="$iotPercent"/>%</span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">Public Transport Status</span>
                                <span class="detail-value">
                                    <xsl:value-of select="count(/smartCity/infrastructure/publicTransport/*[@status='Operational'])"/>/<xsl:value-of select="count(/smartCity/infrastructure/publicTransport/*)"/>
                                </span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">Air Quality Sensors</span>
                                <span class="detail-value"><xsl:value-of select="count(/smartCity/environment/airQuality/sensor)"/></span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">Active Cameras</span>
                                <span class="detail-value">
                                    <xsl:value-of select="count(/smartCity/security/surveillance/camera[@status='Active'])"/>/<xsl:value-of select="count(/smartCity/security/surveillance/camera)"/>
                                </span>
                            </div>
                            <div class="user-detail">
                                <span class="detail-label">Hospital Beds Available</span>
                                <span class="detail-value"><xsl:value-of select="sum(/smartCity/services/hospital/@bedsAvailable)"/></span>
                            </div>
                        </div>
                    </div>
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
            });
            
            document.querySelectorAll('.section').forEach(section => {
                section.classList.remove('active');
            });

            // Add active class to clicked button
            event.currentTarget.classList.add('active');
            
            // Show selected section
            document.getElementById(sectionId).classList.add('active');
        }

        // Initialize animations when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Animate progress bars
            setTimeout(() => {
                document.querySelectorAll('.progress-fill').forEach(bar => {
                    const width = bar.style.width;
                    bar.style.width = '0%';
                    setTimeout(() => {
                        bar.style.width = width;
                    }, 100);
                });
            }, 500);
            
            // Add hover effects
            document.querySelectorAll('.dashboard-card, .kpi-card, .user-card').forEach(card => {
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-5px)';
                });
                
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0)';
                });
            });
        });

        // Real-time update simulation
        setInterval(() => {
            // Animate pulse elements
            const pulseElements = document.querySelectorAll('.pulse');
            pulseElements.forEach(el => {
                el.style.opacity = '0.6';
                setTimeout(() => {
                    el.style.opacity = '1';
                }, 300);
            });
        }, 2000);
    </script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
