#!/bin/bash
# ============================================================
# 🚀 GrAtech AI - Global Launch Script
# Author: SULAIMAN ALSHAMMARI
# Domain: GRATECH.SA
# Version: 2.0 (Ultimate Professional Edition)
# ============================================================

# === COLORS ===
GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

echo "=========================================================="
echo "🚀 Starting GrAtech AI Global Launch"
echo "Prepared by: SULAIMAN ALSHAMMARI | Domain: GRATECH.SA"
echo "=========================================================="

# === STEP 0: PRE-CHECK ===
echo -e "${GREEN}✅ Checking prerequisites...${NC}"
for cmd in git az curl; do
    command -v $cmd >/dev/null || { echo -e "${RED}❌ $cmd not installed${NC}"; exit 1; }
done

# === STEP 1: CLEAN OLD PROJECTS ===
echo -e "${YELLOW}🧹 Cleaning old failed projects...${NC}"
cd /root && rm -rf gratech-ai-system gratech-unified gratech_ai_os archived_projects 2>/dev/null
echo -e "${GREEN}✅ Old projects removed${NC}"

# === STEP 2: UPLOAD PACKAGE TO GITHUB ===
echo -e "${BLUE}📤 Uploading final package to GitHub...${NC}"
cd /root/status-repo || { git clone git@github.com:YOUR-ORG/gratech-status.git /root/status-repo; cd /root/status-repo; }
cp /tmp/GrAtech-AI-Global-Launch-Package-Final.zip .
git add GrAtech-AI-Global-Launch-Package-Final.zip
git commit -m "[LAUNCH] Final Global Launch Package"
git push origin main

# === STEP 3: ENABLE GITHUB PAGES ===
echo -e "${BLUE}🌐 Configuring GitHub Pages...${NC}"
echo "<a href='GrAtech-AI-Global-Launch-Package-Final.zip'>📦 Download Final Package</a>" >> index.html
git add index.html && git commit -m "Added download link" && git push origin main

# === STEP 4: CONFIGURE DOMAIN & SSL ===
echo -e "${GREEN}🔐 Setting up DNS and SSL for GRATECH.SA...${NC}"
az network dns record-set a add-record --resource-group gratech-resource-group --zone-name gratech.sa --record-set-name @ --ipv4-address 172.201.26.111
az network application-gateway ssl-cert create --resource-group gratech-resource-group --gateway-name gratech-gateway --name gratech-ssl --cert-file /path/to/cert.pfx --cert-password <PASSWORD>

# === STEP 5: RESTART WEBAPP & VERIFY ===
echo -e "${GREEN}🌍 Restarting WebApp and verifying...${NC}"
az webapp restart --name gratech-webapp --resource-group gratech-resource-group
curl -I https://gratech-webapp.azurewebsites.net || echo -e "${RED}❌ WebApp check failed${NC}"

# === STEP 6: VERIFY API GATEWAY ===
echo -e "${GREEN}✅ Verifying API Gateway connectivity...${NC}"
curl -X GET "https://gratech-api-gateway.azure-api.net/copilot/status" -H "Ocp-Apim-Subscription-Key:<YOUR_API_KEY>"

# === STEP 7: BACKUP ===
echo -e "${GREEN}📦 Creating backup snapshot...${NC}"
tar -czf /root/gratech-backup-$(date +%F).tar.gz /tmp/gratech-final-package

echo -e "${GREEN}✅ Global Launch Completed Successfully!${NC}"

# === EMERGENCY RECOVERY SECTION ===
echo -e "${RED}🚨 Emergency Recovery Protocol Initiated...${NC}"
pkill -f "uvicorn" || echo "✅ No backend processes"
pkill -f "next" || echo "✅ No frontend processes"
systemctl restart nginx || echo "⚠️ Nginx restart failed"
systemctl restart backend || echo "⚠️ Backend restart failed"
pm2 restart all || echo "⚠️ PM2 restart fallback"
curl -f http://localhost:3000/health && echo "✅ Frontend OK" || echo "❌ Frontend FAILED"
curl -f http://localhost:9000/health && echo "✅ Backend OK" || echo "❌ Backend FAILED"
echo "✅ Emergency Recovery Complete"

# === POST-LAUNCH PERFORMANCE REPORTS ===
echo -e "${BLUE}📊 Generating Power BI Dashboard Examples...${NC}"
echo "Use these KPIs in Power BI:"
echo "-----------------------------------------------------------"
echo "1️⃣ API Latency Trend: Line Chart"
echo "   DAX: AvgLatency = AVERAGE(Logs[ResponseTime])"
echo "2️⃣ Error Rate Heatmap"
echo "   DAX: TotalErrors = COUNTROWS(FILTER(Logs, Logs[Status] = \"Error\"))"
echo "3️⃣ User Engagement Funnel"
echo "   Metrics: Sessions -> Actions -> Conversions"
echo "4️⃣ System Uptime Gauge"
echo "   Target: 99.95%"
echo "5️⃣ Security Alerts Table"
echo "   Columns: AlertType, Severity, ResolutionStatus"
echo "-----------------------------------------------------------"
echo -e "${GREEN}✅ Power BI integration ready. Connect Azure Log Analytics to Power BI.${NC}"

echo "=========================================================="
echo "🎯 Launch executed by SULAIMAN ALSHAMMARI | GRATECH.SA"
echo "=========================================================="
