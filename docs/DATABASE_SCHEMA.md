# Database Schema - Firestore

## Collections Overview

### 1. Users Collection
Stores user profiles and authentication data.

```
/users/{userId}
├── email: string
├── phoneNumber: string
├── fullName: string
├── userType: string (enum: "requester" | "provider" | "both")
├── profileImage: string (URL)
├── bio: string
├── address: string
├── city: string
├── ratings: number (average rating)
├── totalReviews: number
├── verificationStatus: string (enum: "unverified" | "verified" | "rejected")
├── certifications: array
│   ├── {
│   │   ├── title: string
│   │   ├── issuer: string
│   │   ├── issuedDate: timestamp
│   │   ├── expiryDate: timestamp
│   │   ├── certificateURL: string
│   │   ├── verified: boolean
│   ├── }
├── specializations: array (e.g., ["plumbing", "electrical"])
├── bankDetails: object
│   ├── bankName: string
│   ├── accountName: string
│   ├── accountNumber: string
│   ├── branchCode: string
├── createdAt: timestamp
├── updatedAt: timestamp
├── isActive: boolean
```

### 2. Tasks Collection
Stores task postings.

```
/tasks/{taskId}
├── title: string
├── description: string
├── category: string (e.g., "plumbing", "cleaning", "electrical")
├── budget: number
├── currency: string ("ZWL", "USD")
├── location: object
│   ├── address: string
│   ├── city: string
│   ├── latitude: number
│   ├── longitude: number
├── dueDate: timestamp
├── status: string (enum: "open" | "in_progress" | "completed" | "cancelled")
├── createdBy: string (userId)
├── assignedTo: string (userId) - optional until accepted
├── images: array (URLs)
├── requirements: array (specific skills needed)
├── applicants: array
│   ├── {
│   │   ├── providerId: string
│   │   ├── appliedAt: timestamp
│   │   ├── message: string
│   │   ├── proposedPrice: number
│   │   ├── estimatedDays: number
│   │   ├── status: string (enum: "pending" | "accepted" | "rejected")
│   ├── }
├── createdAt: timestamp
├── updatedAt: timestamp
```

### 3. Messages Collection
Real-time messaging between users.

```
/messages/{conversationId}/{messageId}
├── senderId: string (userId)
├── senderName: string
├── senderImage: string (URL)
├── message: string
├── timestamp: timestamp
├── isRead: boolean
├── attachments: array (URLs) - optional
```

### 4. Conversations Collection
Track conversations between users.

```
/conversations/{conversationId}
├── participants: array [userId1, userId2]
├── taskId: string (associated task) - optional
├── lastMessage: string
├── lastMessageTime: timestamp
├── unreadCount: number
├── createdAt: timestamp
├── updatedAt: timestamp
```

### 5. Reviews Collection
Store ratings and reviews.

```
/reviews/{reviewId}
├── taskId: string
├── fromUserId: string (reviewer)
├── toUserId: string (reviewed)
├── rating: number (1-5)
├── comment: string
├── categories: object
│   ├── professionalism: number (1-5)
│   ├── communication: number (1-5)
│   ├── timeliness: number (1-5)
│   ├── quality: number (1-5)
├── images: array (proof/evidence)
├── isAnonymous: boolean
├── createdAt: timestamp
├── updatedAt: timestamp
```

### 6. Payments Collection
Track all payment transactions.

```
/payments/{paymentId}
├── taskId: string
├── payerId: string (requester)
├── payeeId: string (provider)
├── amount: number
├── currency: string ("ZWL", "USD")
├── paymentMethod: string (enum: "ecocash" | "innbucks" | "onemoney" | "omari")
├── transactionId: string (external payment gateway ref)
├── status: string (enum: "pending" | "completed" | "failed" | "refunded")
├── description: string
├── metadata: object
│   ├── phoneNumber: string
│   ├── merchantReference: string
│   ├── externalReference: string
├── createdAt: timestamp
├── updatedAt: timestamp
├── failureReason: string - optional
```

### 7. Notifications Collection
User notifications.

```
/notifications/{userId}/{notificationId}
├── type: string (enum: "task_update" | "message" | "review" | "payment" | "application")
├── title: string
├── body: string
├── relatedId: string (taskId, messageId, etc.)
├── relatedType: string
├── isRead: boolean
├── createdAt: timestamp
```

### 8. Categories Collection
Predefined task categories.

```
/categories/{categoryId}
├── name: string
├── description: string
├── icon: string (URL)
├── subcategories: array
├── isActive: boolean
```

---

## Firestore Security Rules (Basic)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users can only read/write their own profile
    match /users/{userId} {
      allow read: if request.auth.uid != null;
      allow write: if request.auth.uid == userId;
    }
    
    // Anyone can read tasks, only creator can modify
    match /tasks/{taskId} {
      allow read: if request.auth.uid != null;
      allow create: if request.auth.uid != null;
      allow update: if request.auth.uid == resource.data.createdBy;
      allow delete: if request.auth.uid == resource.data.createdBy;
    }
    
    // Messages - only participants can access
    match /conversations/{conversationId}/{document=**} {
      allow read, write: if request.auth.uid in resource.data.participants;
    }
    
    // Reviews - public read, authenticated create
    match /reviews/{reviewId} {
      allow read: if request.auth.uid != null;
      allow create: if request.auth.uid != null;
      allow update: if request.auth.uid == resource.data.fromUserId;
    }
    
    // Payments - only involved parties
    match /payments/{paymentId} {
      allow read: if request.auth.uid == resource.data.payerId || request.auth.uid == resource.data.payeeId;
      allow create: if request.auth.uid != null;
    }
  }
}
```

---

## Indexes Required

1. **Tasks**
   - Composite: `status`, `city`, `createdAt`
   - Composite: `category`, `status`, `createdAt`

2. **Reviews**
   - Composite: `toUserId`, `createdAt`

3. **Messages**
   - Single: `timestamp` (descending)

---

## Data Relationships

```
User (1) ─── (many) Tasks (created)
User (1) ─── (many) Reviews (received)
User (1) ─── (many) Payments (sent/received)
Task (1) ─── (many) Applications/Applicants
Task (1) ─── (many) Messages
```
