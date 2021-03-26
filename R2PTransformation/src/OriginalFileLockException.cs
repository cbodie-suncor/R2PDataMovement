using System;
using System.Runtime.Serialization;

namespace SuncorR2P {
    [Serializable]
    public class OriginalFileLockException : Exception {
        public OriginalFileLockException() {
        }

        public OriginalFileLockException(string message) : base(message) {
        }

        public OriginalFileLockException(string message, Exception innerException) : base(message, innerException) {
        }

        protected OriginalFileLockException(SerializationInfo info, StreamingContext context) : base(info, context) {
        }
    }
}