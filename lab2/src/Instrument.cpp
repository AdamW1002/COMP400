#include "Instrument.h"
#include "llvm/IR/Type.h"

#include <iostream>
#include <string>
#include <sstream>

using namespace llvm;

namespace instrument
{

  static const char *SanitizerFunctionName = "__sanitize__";
  static const char *CoverageFunctionName = "__coverage__";
  static const char *LogFunctionName = "__log_function__";

  void log(Module *M, Function &F, Instruction &I)
  {

    if (I.getOpcode() == Instruction::Call)
    {
        outs () << cast<CallInst>(I).getCalledFunction()->getName() << "\n"; //dbg
     
     
     
      
          
          
          Value* v = M->getOrInsertFunction(LogFunctionName,
                                                Type::getVoidTy(I.getContext()),
                                                Type::getInt8PtrTy(I.getContext()), Type::getInt8PtrTy(I.getContext())

                                                    ).getCallee();

    //from provided materials
      Function *logger = 
          cast<Function> (v); 


      std::stringstream ss; //Used for concat an unknown number of strings 


      //iterate thru operands and concat them
      for (int i = 0; i < I.getNumOperands(); i++)
      {
          
        std::string BBName;

        if (!(I.getOperand(i))->getName().empty())
        {

          BBName = I.getOperand(i)->getName().str();
          ss << BBName;
        }
        else
        {
          raw_string_ostream OS(BBName);

          (I.getOperand(i))->printAsOperand(OS, true);
          OS.flush();

          ss << BBName;
        }
        ss << " ";
      }

      auto ops = ss.str();

      IRBuilder<> builder(&I); //Build our strings
      builder.SetInsertPoint(&I);

      Value *operands = builder.CreateGlobalStringPtr(ops, Twine("Test"));
      Value *funcName = builder.CreateGlobalStringPtr(cast<CallInst>(I).getCalledFunction()->getName(), Twine("Test"));

      std::vector<Value *> args;
      args.push_back(funcName);
      args.push_back(operands);

      CallInst *Call = CallInst::Create(logger->getFunctionType(), logger, args, Twine(""), &I); //insert string
    }
  }

  /*
 * Implement divide-by-zero sanitizer.
 */

  void instrumentSanitize(Module *M, Function &F, Instruction &I)
  {
    /* Add you code here */
    if (I.getOpcode() == Instruction::And)
    {
      new AllocaInst(Type::getInt32Ty(I.getContext()), NULL, Twine("test"), &I);
    }
    /*else if (I.getOpcode() == Instruction::Call)
    {
      new AllocaInst(Type::getInt32Ty(I.getContext()), NULL, Twine("test2"), &I);
    }*/

    else if (I.getOpcode() == Instruction::SDiv || I.getOpcode() == Instruction::UDiv)
    {

      Type *int32 = Type::getInt32Ty(I.getContext());

      Function *helper =
          cast<Function>(M->getOrInsertFunction(SanitizerFunctionName,
                                                Type::getVoidTy(I.getContext()),
                                                Type::getInt32Ty(I.getContext()), Type::getInt32Ty(I.getContext()), Type::getInt32Ty(I.getContext())).getCallee());

      std::vector<Value *> args;
      args.push_back(I.getOperand(0));

      args.push_back(ConstantInt::get(int32, I.getDebugLoc().getLine(), false));
      args.push_back(ConstantInt::get(int32, I.getDebugLoc().getCol(), false));
      CallInst *Call = CallInst::Create(helper->getFunctionType(), helper, args, Twine(""), &I);

      outs() << "\n";
    }
  }

  /*
 * Implement code coverage instrumentation.
 */
  void instrumentCoverage(Module *M, Function &F, Instruction &I)
  {
    /* Add you code here */
  }

  bool Instrument::runOnFunction(Function &F)
  {
    /* Add you code here */
    for (BasicBlock &B : F)
    {
      for (Instruction &I : B)
      {

        instrumentSanitize(F.getParent(), F, I);
        log(F.getParent(), F, I);
      }
    }

    return true;
  }

  char Instrument::ID = 1;
  static RegisterPass<Instrument>
      X("Instrument", "Instrumentations for Dynamic Analysis", false, false);

} // namespace instrument
