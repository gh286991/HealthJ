# HealthProJ - Health Record Management System

[![License: Custom](https://img.shields.io/badge/License-Custom-blue.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/Node.js-24.3.0-green.svg)](https://nodejs.org/)
[![Frontend](https://img.shields.io/badge/Frontend-Next.js%2015-black.svg)](https://nextjs.org/)
[![Backend](https://img.shields.io/badge/Backend-NestJS-red.svg)](https://nestjs.com/)

A modern, full-stack health record management system with Progressive Web App (PWA) capabilities. Built for tracking nutrition, diet records, and personal health data with a focus on user experience and data security.

[繁體中文文檔](README.zh-TW.md) | [English](README.md)

## Features

### Authentication & Security
- User registration and login system
- JWT authentication

### Health Record Management
- Personal diet and nutrition tracking
- Food database management with comprehensive nutrition data
- Daily nutrition intake monitoring
- Personal profile management with health metrics

### Progressive Web App (PWA)
- Offline functionality
- Mobile-responsive design
- App-like experience on mobile devices

## Tech Stack

### Backend (NestJS)
- **Framework**: NestJS 10.x
- **Database**: MongoDB
- **Authentication**: JWT + Passport
- **File Storage**: MinIO
- **API Documentation**: Swagger

### Frontend (Next.js)
- **Framework**: Next.js 15
- **Language**: TypeScript
- **Styling**: Tailwind CSS 4

### Development Tools
- **Package Manager**: Yarn
- **Linting**: ESLint
- **Type Checking**: TypeScript
- **Testing**: Jest
- **Process Management**: Concurrently

## Quick Start

### Prerequisites

- Node.js 24.3.0+ (Required)
- Yarn package manager
- MongoDB database
- MinIO server (for file storage)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd HealthProj
   ```

2. **Install all dependencies**
   ```bash
   yarn install:all
   ```

3. **Start development servers**
   ```bash
   yarn dev
   ```

   This will start both frontend and backend concurrently:
   - Frontend: http://localhost:3030
   - Backend: http://localhost:9000
   - API Documentation: http://localhost:9000/api

### Alternative Installation Methods

#### Using startup scripts
```bash
# macOS/Linux
./start-dev.sh

# Windows
start-dev.bat
```

## 🚀 Deployment with GitFlow

This project includes a complete GitFlow workflow for automated deployment to Zeabur without requiring Docker Hub:

### Quick Deployment
```bash
# Setup GitFlow branches
chmod +x scripts/setup-gitflow.sh
./scripts/setup-gitflow.sh

# Quick deployment script
chmod +x scripts/quick-deploy.sh
./scripts/quick-deploy.sh
```

### Manual Deployment via GitHub Actions
1. Go to **Actions** tab in your GitHub repository
2. Select **🚀 Deploy to Zeabur** workflow
3. Click **Run workflow**
4. Choose environment (dev/stg/prod) and input backend/frontend branch names
5. Configure build options and deploy

**🆕 Dynamic Branch Detection**: The workflow automatically detects all available branches in your backend and frontend projects, so you can input any existing branch name without predefined options.

**🔧 Environment Variables**: Runtime environment variables are configured in Zeabur, making deployment more flexible and secure.

### Deployment Process
- **Build**: Automatically builds both backend and frontend using Docker
- **Test**: Runs unit tests and E2E tests in Docker containers before deployment
- **Deploy**: Uploads build artifacts to Zeabur using their CLI
- **Docker-based**: Uses existing Dockerfiles for consistent build environments

### Supported Environments
- **dev** (develop branch) - Development environment
- **stg** (staging branch) - Testing environment  
- **prod** (main branch) - Production environment

For detailed setup instructions, see [GitFlow Guide](GITFLOW-GUIDE.md) and [GitHub Secrets Setup](docs/SETUP-GITHUB-SECRETS.md).

## Project Structure

```
HealthProj/
├── HealthRecord/          # Backend (NestJS)
│   ├── src/
│   │   ├── auth/          # Authentication module
│   │   ├── diet/          # Diet records management
│   │   ├── food/          # Food database management
│   │   └── common/        # Shared services (MinIO, etc.)
│   └── package.json
├── HealthRecord-FE/       # Frontend (Next.js)
│   ├── src/
│   │   ├── app/           # Next.js App Router pages
│   │   ├── components/    # Reusable components
│   │   └── lib/           # API services and utilities
│   └── package.json
├── start-dev.sh          # Unix startup script
├── start-dev.bat         # Windows startup script
└── package.json          # Root package management
```

## 🔒 Environment Configuration

Create appropriate environment files for your deployment:

## 📱 PWA Features

The frontend is built as a Progressive Web App with:
- Offline functionality
- Service worker for caching
- Manifest file for app installation
- Responsive design for all devices

## 🤝 Contributing

This project is primarily for personal/educational use. If you're interested in contributing or using this commercially, please contact the author.

## 📄 License

This project is licensed under a **Custom License**:

- ✅ **Open Source**: Free for personal, educational, and non-commercial use
- ❌ **Commercial Use Prohibited**: Commercial use requires explicit permission
- 💼 **Commercial Licensing**: Contact the author for commercial licensing terms

**For commercial use inquiries, please contact**: [Your Contact Information]

Any commercial use without proper licensing will be subject to legal action.

## 🆘 Support & Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 3030 and 9000 are available
2. **Node version**: Make sure you're using Node.js 24.3.0+
3. **Dependencies**: Run `yarn install:all` if you encounter missing dependencies

### Getting Help

1. Check the [START-GUIDE.md](START-GUIDE.md) for detailed setup instructions
2. Review the API documentation at http://localhost:9000/api
3. For support, please create an issue in the repository

## 🎯 Future Roadmap

- [ ] Enhanced nutrition analysis
- [ ] Goal setting and progress tracking
- [ ] Social features for sharing progress
- [ ] Integration with fitness trackers
- [ ] Advanced reporting and analytics
- [ ] Multi-language support

---

**Disclaimer**: This health management system is for informational purposes only and should not replace professional medical advice. Always consult with healthcare professionals for medical decisions. 