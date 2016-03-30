using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JobWatchData.Models
{
    class Job
    {
        public int ID { get; set; }
        public Company Company { get; set; }
        public string Title { get; set; }
        public Type Type { get; set; }
        public string Url { get; set; }
        public Location Location { get; set; }
        public string Description { get; set; }
        public DateTime DateListed { get; set; }
        public DateTime DateApplied { get; set; }
        public bool IsActive { get; set; }
        public IntermediatePhase IntermediatePhase { get; set; }
        public int InterviewCount { get; set; }
        public OfferPhase OfferPhase { get; set; }
        public decimal OfferedSalary { get; set; }
        public bool RejectionStatus { get; set; }
    }
}
